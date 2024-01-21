build:
	bun build src/index.ts --outfile dist/index.js
	podman build --tag blog .

run: build
	podman run -p 8080:8080 --name korea-blog --replace localhost/blog

stop:
	podman stop korea-blog

install-hexo:
	cp -f prep/hexo/_config.yml ./hexo
	cd ./hexo && npm install

install-theme:
	rm -rf ./hexo/themes/tranquilpeak
	curl -L https://github.com/LouisBarranqueiro/hexo-theme-tranquilpeak/archive/main.zip --output theme.zip
	unzip -o theme.zip
	mv hexo-theme-tranquilpeak-main tranquilpeak
	mv tranquilpeak ./hexo/themes
	cd ./hexo/themes/tranquilpeak && npm i && npm run prod
	cp -f prep/images/my-cover.jpg ./hexo/themes/tranquilpeak/source/assets/images
	cp -f prep/theme/_config.yml ./hexo/themes/tranquilpeak
	rm -f theme.zip

public:
	cd ./hexo && npx hexo generate
