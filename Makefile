# Makefile untuk Olshop Infrastructure
# Memudahkan clone, build, dan operasi docker-compose sehari-hari.

.PHONY: help clone pull build up down logs ps clean

help: ## Tampilkan daftar perintah yang tersedia
	@echo "Perintah yang tersedia:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  make %-15s %s\n", $$1, $$2}'

clone: ## Clone ketiga repository ke folder ini
	git clone https://github.com/mahfudz19/shop-api.git shop-api || true
	git clone https://github.com/mahfudz19/shop-frontend.git shop-frontend || true
	git clone https://github.com/mahfudz19/tokopedia-scraper.git tokopedia-scraper || true

pull: ## Pull update terbaru dari semua repository
	@echo "Pulling latest updates..."
	@for dir in shop-api shop-frontend tokopedia-scraper; do \
		if [ -d "$$dir/.git" ]; then \
			echo "Updating $$dir..."; \
			cd $$dir && git pull && cd ..; \
		else \
			echo "[!] $$dir bukan repository git, lewati."; \
		fi \
	done

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
