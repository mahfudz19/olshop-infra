# Olshop Infrastructure

Repo orchestration untuk menjalankan 3 layanan utama Olshop secara bersamaan dengan Docker Compose:

1. [tokopedia-scraper](../tokopedia-scraper) — Python/FastAPI scraper dengan Playwright + noVNC
2. [shop-api](../shop-api) — Go/Gin REST API
3. [shop-frontend](../shop-frontend) — Next.js 16 frontend

## Struktur Folder

```
olshop-infra/
├── docker-compose.yml   # Definisi service, tanpa credential
├── .env                 # Value asli environment (tidak di-commit)
├── .env.example         # Template environment
├── .gitignore           # Meng-ignore .env dan subfolder project
├── Makefile             # Shortcut perintah sehari-hari
└── README.md            # Dokumentasi ini
```

## Prasyarat

- Docker Engine >= 20.10
- Docker Compose >= 2.20
- (Opsional) `make` untuk shortcut Makefile

## Setup

1. **Clone ketiga repo** ke dalam folder ini:

   ```bash
   make clone
   ```

   Atau clone manual:

   ```bash
   git clone https://github.com/username/shop-api.git shop-api
   git clone https://github.com/username/shop-frontend.git shop-frontend
   git clone https://github.com/username/tokopedia-scraper.git tokopedia-scraper
   ```

2. **Salin dan isi environment**:

   ```bash
   cp .env.example .env
   # Edit .env sesuai environment target
   ```

3. **Build image**:

   ```bash
   make build
   ```

4. **Jalankan service**:

   ```bash
   make up
   ```

## Urutan Build

Docker Compose akan mem-build dan menjalankan service sesuai dependensi:

1. `tokopedia-scraper` — di-build dan dijalankan pertama
2. `shop-api` — menunggu scraper healthy
3. `shop-frontend` — menunggu API dan scraper healthy

## Perintah Berguna

| Perintah     | Fungsi                    |
| ------------ | ------------------------- |
| `make build` | Build semua image         |
| `make up`    | Jalankan semua service    |
| `make down`  | Hentikan container        |
| `make logs`  | Lihat log realtime        |
| `make ps`    | Cek status container      |
| `make clean` | Hentikan dan hapus volume |

## Akses Layanan

| Layanan               | URL Lokal             |
| --------------------- | --------------------- |
| Shop Frontend         | http://localhost:3000 |
| Shop API              | http://localhost:8080 |
| Tokopedia Scraper API | http://localhost:8000 |
| noVNC Scraper         | http://localhost:6080 |

## Keamanan

- **Jangan commit file `.env`** — sudah di-ignore oleh `.gitignore`.
- Semua credential disimpan di `.env`, sedangkan `docker-compose.yml` hanya memanggil variabel via `${VAR}`.
- Untuk production, gunakan secret manager atau Docker secrets.
