.PHONY: publish clean dry-run dry-css dry-content dry-js js css content

public:
	hugo

dry-content:
	s3cmd sync --dry-run \
			   -P -M --add-header=Cache-Control:maxage=60 --delete-removed \
			   --exclude *.css \
			   --exclude *.js \
			   public/ s3://xn.io/
dry-js:
	s3cmd sync --dry-run \
		       -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   -m application/javascript \
			   --rexclude .  \
			   --rinclude .+\.js \
			   public/ s3://xn.io/

dry-css:
	s3cmd sync --dry-run \
 		       -P --add-header=Cache-Control:maxage=60 --delete-removed \
 			   -m text/css \
 			   --rexclude .  \
 			   --rinclude .+\.css \
 			   public/ s3://xn.io/

dry-run: dry-css dry-js dry-content

content:
	s3cmd sync -P -M --add-header=Cache-Control:maxage=60 --delete-removed \
			   --exclude *.css \
			   --exclude *.js \
			   public/ s3://xn.io/
js:
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   -m application/javascript \
			   --rexclude .  \
			   --rinclude .+\.js \
			   public/ s3://xn.io/

css:
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
 			   -m text/css \
 			   --rexclude .  \
 			   --rinclude .+\.css \
 			   public/ s3://xn.io/

publish: js css content
	s3cmd sync -P -M --add-header=Cache-Control:maxage=60 --delete-removed \
			   --exclude *.css \
			   --exclude *.js \
			   public/ s3://xn.io/
clean:
	rm -rf public
