import os
from pathlib import Path

import requests
from google import genai
from google.genai import types

# List of 20 German/European news homepages
NEWS_URLS = [
    "https://www.spiegel.de",
    "https://www.sueddeutsche.de",
    "https://www.faz.net",
    "https://www.welt.de",
    "https://www.tagesschau.de",
    "https://www.n-tv.de",
    "https://www.handelsblatt.com",
    "https://www.dw.com",
    "https://www.bild.de",
    "https://www.heise.de",
    "https://www.lemonde.fr",
    "https://www.lefigaro.fr",
    "https://www.corriere.it",
    "https://www.repubblica.it",
    "https://www.theguardian.com",
    "https://www.elpais.com",
    "https://www.lavanguardia.com",
    "https://www.euronews.com",
    "https://www.ft.com",
    "https://www.diepresse.com",
]

out_dir = Path("data/03_ai-tools")
out_dir.mkdir(parents=True, exist_ok=True)


def fetch_md(url):
    try:
        r = requests.get("https://r.jina.ai/" + url, timeout=15)
        r.raise_for_status()
        return r.json().get("content", "")
    except Exception as e:
        return f"Error: {e}"


def fname(url):
    d = url.split("//")[-1]
    if d.startswith("www."):
        d = d[4:]
    return f"{d.replace('/', '_')}.md"


# Step 1: Retrieve and save articles
for url in NEWS_URLS:
    md = fetch_md(url)
    if md:
        with open(out_dir / fname(url), "w", encoding="utf-8") as f:
            f.write(md)

# Step 2: Load saved articles into a dict {filename: content}
articles = {}
for f in out_dir.glob("*.md"):
    with open(f, encoding="utf-8") as file:
        articles[f.stem] = file.read()

# Initialize Gemini client using environment variables
API_KEY = os.environ.get("GEMINI_API_KEY")
if not API_KEY:
    raise ValueError("GEMINI_API_KEY not set")
MODEL = os.environ.get("GEMINI_MODEL", "gemini-2.0-flash")
client = genai.Client(api_key=API_KEY)


def gemini_query(prompt):
    resp = client.models.generate_content(
        model=MODEL,
        contents=prompt,
        config=types.GenerateContentConfig(max_output_tokens=500, temperature=0.3),
    )
    return resp.text


# Five queries:

# Query 1: For each individual article, summarize main headlines.
print("=== Query 1: Summaries for individual pages ===")
for name, content in articles.items():
    prompt = f"Summarize the main headlines and key news on the following page from {name}:\n\n{content[:1000]}"
    summary = gemini_query(prompt)
    print(f"\n[{name}]")
    print(summary)

# Query 2: Extract emerging trends on one specific page (choose one, e.g., "spiegel.de")
if "spiegel.de" in articles:
    prompt = f"From the following content from spiegel.de, list 3 emerging news trends:\n\n{articles['spiegel.de'][:1500]}"
    print("\n=== Query 2: Emerging trends on spiegel.de ===")
    print(gemini_query(prompt))

# Query 3: For an individual page (e.g., "dw.com"), get a creative summary.
if "dw.com" in articles:
    prompt = f"Provide a creative summary of today's news as presented on dw.com:\n\n{articles['dw.com'][:1500]}"
    print("\n=== Query 3: Creative summary for dw.com ===")
    print(gemini_query(prompt))

# Query 4: On full dataset: What are the major news trends across these European sources?
full_text = "\n\n".join(articles.values())
prompt = (
    "Based on the following combined news articles from 20 major European news sources, "
    "list 5 major news trends and summarize the overall current news landscape:\n\n"
    + full_text[:5000]
)
print("\n=== Query 4: Overall European news trends ===")
print(gemini_query(prompt))

# Query 5: Analyze how technology/AI is covered across these sources.
prompt = (
    "Using the following combined text from various European news sources, "
    "analyze and summarize how technology and AI are being covered in today's news. "
    "Highlight any emerging themes or concerns:\n\n" + full_text[:5000]
)
print("\n=== Query 5: Technology and AI coverage analysis ===")
print(gemini_query(prompt))
