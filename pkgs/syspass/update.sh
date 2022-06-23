#! /usr/bin/env nix-shell
#! nix-shell -i bash -p php74 php74.packages.composer wget git python

if [ $# -lt 1 ]; then
  echo "Usage: ./update.sh <new_version>"
  echo "Updates syspass derivation to the given git-tag version."
  echo "Please make sure this tag actually exists."
  echo "cf https://github.com/nuxsmin/sysPass/tags."
  exit 1
fi

version=$1
cur_dir=$(pwd)

temp_dir=$(mktemp -d)
pushd $temp_dir

  # First we need to build composer2nix, it's quick though
  git clone --branch master --depth 1 https://github.com/svanderburg/composer2nix
  pushd composer2nix
    nix-build
  popd

  wget "https://github.com/nuxsmin/sysPass/raw/${version}/composer.json" -O composer.json
  cp $cur_dir/remove-phpunit-composer-json.py .
  python remove-phpunit-composer-json.py > composer.json.fixed
  mv composer.json.fixed composer.json
  cat composer.json
  composer install --no-dev
  ./composer2nix/result/bin/composer2nix
popd

cp $temp_dir/composer.json .
cp $temp_dir/composer.lock .
cp $temp_dir/composer-env.nix .
cp $temp_dir/php-packages.nix .
patch php-packages.nix php-packages.patch
sed -i "s/syspass-syspass/syspass-$version/" php-packages.nix
sed -iE "s/rev = \".*\"/rev = \"$version\"/" default.nix

rm -rf $temp_dir
