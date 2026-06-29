# Makefile untuk Olshop Infrastructure
# Memudahkan clone, build, dan operasi docker-compose sehari-hari.

.PHONY: help clone build up down logs ps clean

help: ## Tampilkan daftar perintah yang tersedia
	@echo "Perintah yang tersedia:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  make %-15s %s\n", $$1, $$2}'

clone: ## Clone ketiga repository ke folder ini
	git clone https://github.com/username/shop-api.git shop-api || true
	git clone https://github.com/username/shop-frontend.git shop-frontend || true
	git clone https://github.com/username/tokopedia-scraper.git tokopedia-scraper || true

build: ## Build semua image docker
	docker compose build

up: ## Jalankan semua service di background
	docker compose up -d

down: ## Hentikan dan hapus container
	docker compose down

logs: ## Tampilkan log semua service (follow)
	docker compose logs -f

ps: ## Tampilkan status container
	docker compose ps

clean: ## Hentikan container dan hapus volume
	docker compose down -v
