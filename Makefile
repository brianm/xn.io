.PHONY: publish clean dry-run

public:
	hugo

dry-run: public
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   --dry-run \
			   -m application/javascript \
			   --rexclude .  \
			   --rinclude .+\.js \
			   public/ s3://xn.io/
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   --dry-run \
			   -m text/css \
			   --rexclude .  \
			   --rinclude .+\.css \
			   public/ s3://xn.io/
	s3cmd sync -P -M --add-header=Cache-Control:maxage=60 --delete-removed \
			   --dry-run \
			   --exclude *.css \
			   --exclude *.js \
			   public/ s3://xn.io/

publish: public
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   -m application/javascript \
			   --rexclude .  \
			   --rinclude .+\.js \
			   public/ s3://xn.io/
	s3cmd sync -P --add-header=Cache-Control:maxage=60 --delete-removed \
			   -m text/css \
			   --rexclude .  \
			   --rinclude .+\.css \
			   public/ s3://xn.io/
	s3cmd sync -P -M --add-header=Cache-Control:maxage=60 --delete-removed \
			   --exclude *.css \
			   --exclude *.js \
			   public/ s3://xn.io/
clean:
	rm -rf public
