# B.AVLAYAN — retro ASCII güvenlik blogu

Hugo ile çalışan statik site. Dış font, CDN, analitik ve çerez yok; çıktı düz
HTML + tek bir CSS dosyası.

## Hızlı başlangıç

```bash
# 1. Hugo kur (tek ikili dosya, bağımlılık yok)
#    macOS:    brew install hugo
#    Windows:  winget install Hugo.Hugo.Extended
#    Linux:    https://github.com/gohugoio/hugo/releases

# 2. Yerelde çalıştır
hugo server -D          # http://localhost:1313

# 3. Üretim çıktısı
hugo --minify           # public/ klasörüne yazar
```

Test edildiği sürüm: **Hugo 0.166.0**. En az 0.146 gerekiyor (yeni şablon düzeni).

## Yeni yazı

```bash
hugo new content/yazilar/spn-envanteri.md
```

Ön bilgi (front matter):

```yaml
---
title: "SPN envanterini canlı tutmak"
date: 2026-09-18
etiketler: ["active-directory", "tespit"]   # ilki listede rozet olarak görünür
summary: "Dizinde ve RSS'te görünen özet."
draft: true                                  # yayına hazır olunca sil
---
```

Yazı gövdesi normal Markdown. Temaya özel iki kısa kod var:

```markdown
{{< not baslik="Uyarı:" >}}
Kenarlıklı uyarı kutusu. İçi Markdown olarak işlenir.
{{< /not >}}

{{< term >}}
$ komut --ornek
çıktı satırı
{{< /term >}}
```

Kod blokları normal ``` çitleriyle yazılır; renklendirme temanın paletine bağlı.

## Neyi nereden değiştirirsiniz

| Ne | Dosya |
|---|---|
| ASCII logo | `assets/banner.txt` |
| Site adı, motd, e-posta, PGP, lisans | `hugo.toml` → `[params]` |
| Giriş paragrafı ("hakkında") | `content/_index.md` |
| Deneyim bölümü | `data/deneyim.yaml` |
| Menü | `hugo.toml` → `[[menus.main]]` (sıra numarası `weight`) |
| Renkler, tipografi, düzen | `assets/css/main.css` (en üstteki `:root` değişkenleri) |
| Fosfor varyantları | `main.css` → `[data-phos="green"]` / `["ice"]` |

Yeni bir fosfor rengi eklemek için `main.css`'e bir `[data-phos="..."]` bloğu,
`layouts/_partials/header.html`'e de bir düğme ekleyin.

## Yayınlama

**GitHub Pages** — `.github/workflows/deploy.yml` hazır. Depo ayarlarında
Settings → Pages → Source = *GitHub Actions* seçin, `main` dalına push edin.
`hugo.toml` içindeki `baseURL` iş akışı tarafından geçersiz kılınır.

**Cloudflare Pages / Netlify** — depoyu bağlayın, derleme komutu `hugo --minify`,
çıktı dizini `public`, ortam değişkeni `HUGO_VERSION=0.166.0`.

**Kendi sunucunuz** — `Dockerfile` ve `nginx.conf` dahil:

```bash
docker build -t bavlayan-blog .
docker run --rm -p 8080:80 bavlayan-blog
```

Ya da sadece `hugo --minify` çıktısındaki `public/` klasörünü herhangi bir web
sunucusuna kopyalayın. Kurulum gerektiren hiçbir şey yok.

## Alan adı

Kendi alan adınızı kullanacaksanız `hugo.toml` içindeki `baseURL` değerini
güncelleyin, sağlayıcınızda DNS kaydını yönlendirin. GitHub Pages için ayrıca
`static/CNAME` dosyasına alan adını yazın.
