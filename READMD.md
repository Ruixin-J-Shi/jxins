# jxins – Ruixin Shi’s Personal Site

A lightweight, fully responsive static website showcasing portfolio.  
Includes:

- **Homepage (`index.html`)** – Blog & portfolio landing page (blog section under construction).  
- **Résumé (`resume.html`)** – HTML résumé/CV with responsive two-column layout and PDF download.  
- **Standalone PDF (`resume.pdf`)** – One-page PDF version of the résumé.  
- **Assets**  
  - `portrait.png` – Circular avatar used on both pages  
  - `resume.png` – PNG snapshot preview of résumé  
  - `images/` – Additional image assets (favicon, gallery images, etc.)

> **Note:** The blog/gallery portion of the homepage is still under construction. Placeholder sections and lightbox logic are in place, but no active posts are yet published.

---

## Table of Contents

1. [Demo](#demo)
2. [Repository Structure](#Repository Structure)
3. [Getting Started](#getting-started)  
4. [Future Work](#future-work)  
5. [License](#license)  

---

## Demo

> To see the site live, point your browser to the root folder on your static web server.  
> visit:
>
> ```
> https://jxins.duckdns.org
> ```

---

## Repository Structure

jxins-personal-site/
├── images/
│ ├── favico/
│ │ └── favicon.ico 
│ └── (gallery images…) 
│
├── _gallery.html # (server‐included in index.html)
├── index.html # Homepage (Blog & Portfolio) – Blog under construction
├── resume.html # HTML résumé/CV page
└── README.md # This documentation


## Getting-started

No build tools or dependencies are required. You only need:

- A modern web browser (Chrome, Firefox, Safari, Edge).  
- Optionally, a static‐file server for local testing:
  - **Python 3**: 
    ```bash
    python3 -m http.server 8000
    ```
  - **Node “serve”** (via npm):  
    ```bash
    npm install -g serve
    serve .
    ```

MIT License

Copyright (c) 2025
Permission is hereby granted, free of charge, to any person obtaining a copy
… (rest of MIT license text) …

