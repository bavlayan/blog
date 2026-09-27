.PHONY: sunucu derle yeni temizle docker

sunucu:            ## yerelde canlı önizleme (taslaklar dahil)
	hugo server -D --navigateToChanged

derle:             ## public/ altına üretim çıktısı
	hugo --minify

yeni:              ## make yeni BASLIK=yeni-yazi
	hugo new content/yazilar/$(BASLIK).md

temizle:
	rm -rf public resources .hugo_build.lock

docker:
	docker build -t bavlayan-blog . && docker run --rm -p 8080:80 bavlayan-blog
