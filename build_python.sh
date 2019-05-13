#!/usr/bin/env bash

sudo chown vagrant "$HOME"/host/*
HOST="$/Users/vagrant/host"
# On the MacOS VM, brew and OpenSSL are already installed

# For some reason the build for 3.7.3 cannot find the OpenSSL stuff...
# VERSION="3.7.3"
VERSION="3.6.5"
VERSIONMINOR="3.6"


echo "Installing requirements..."
brew update
brew install wget
brew install openssl
brew install zlib
brew install tk-tcl


echo "Checking current working directory..."
CURRENT_DIR="$PWD"
echo "$CURRENT_DIR"

BUILD_OUT="$CURRENT_DIR/python"

echo "Downloading and uncompressing Python source distribution..."
# wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz
wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz
tar -zxvf Python-$VERSION.tgz &> /dev/null

cd Python-$VERSION || exit
echo "Configuring Python..."
# ./configure MACOSX_DEPLOYMENT_TARGET=10.14 CPPFLAGS="-I$OPENSSL_ROOT/include" LDFLAGS="-L$OPENSSL_ROOT/lib" CFLAGS="-I$(xcrun --show-sdk-path)/usr/include" --prefix="$CURRENT_DIR/python"

#./configure CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include -L/usr/local/opt/tcl-tk/lib" LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/tcl-tk/lib" --prefix="$CURRENT_DIR/python"

#./configure CPPFLAGS="-I/usr/local/opt/openssl/include" LDFLAGS="-L/usr/local/opt/openssl/lib" --prefix="$CURRENT_DIR/python" --enable-optimizations

./configure CPPFLAGS="-I/usr/local/opt/openssl/include -I/usr/local/opt/zlib/include -L/usr/local/opt/tcl-tk/lib" LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/opt/zlib/lib -L/usr/local/opt/tcl-tk/lib" --prefix="$BUILD_OUT" --enable-optimizations > "$CURRENT_DIR"/configure.log 2>&1

echo "Building Python..."
make altinstall > "$CURRENT_DIR"/make.log 2>&1

cd "$CURRENT_DIR" || exit

echo "Checking if Python seems to be alright..."
"$BUILD_OUT"/bin/python"$VERSIONMINOR" -c "import ssl; print(ssl.OPENSSL_VERSION)"
"$BUILD_OUT"/bin/pip"$VERSIONMINOR" --version

otool -L "$BUILD_OUT"/bin/python"$VERSIONMINOR"
du -sk "$BUILD_OUT"

echo "Turning the Python distribution into a Mu Editor App..."
echo "Installing Mu Editor..."
"$BUILD_OUT"/bin/pip3.6 install mu-editor

cp "$HOST"/mu_env.sh "$BUILD_OUT"/bin
#TODO: Replace shebang of pip3.6 of mu-editor in bin
# I will just do that for all scripts in there...
# for SCRPT in `find "$BUILD_OUT"/bin -type f`
# do
#     #TODO: Only do that for text files, i.e., scripts!
#     echo "$SCRPT"
#     if file -b "$SCRPT" | grep 'ASCII' &>/dev/null
#     then
#         sed -i '' "s/Users\/vagrant\/python\/bin\/python3\.6/Applications\/mu-editor\.app\/Contents\/Resources\/python\/bin\/python3\.6/" "$SCRPT"
#     fi
# done

# Multiline strings in Bash come from here: https://stackoverflow.com/a/23930212
read -r -d '' _inner_loop <<"EOF"
for SCRPT in $1
do
    if file -b "$SCRPT" | grep 'ASCII' &>/dev/null
    then
        echo "Modifying shebang for $SCRPT"
        sed -i '' "s/Users\/vagrant\/python\/bin\/python3\.6/Applications\/mu-editor\.app\/Contents\/Resources\/python\/bin\/python3\.6/" "$SCRPT"
    fi
done
EOF

# -exec comes from https://unix.stackexchange.com/a/193873
find "$BUILD_OUT"/bin -type f -exec bash -c "$_inner_loop" none {}  \;






#for SCRPT in `find $BUILD_OUT/bin -type f`; do sed -i '' "s/Users\/vagrant\/python\/bin\/python3\.6/Applications\/mu-editor\.app\/Contents\/Resources\/python\/bin\/python3\.6/" $SCRPT; done

# for SCRPT in `find $BUILD_OUT/bin -type f`; do echo $SCRPT; if file -b $SCRPT | grep 'ASCII' &>/dev/null; then head -1 $SCRPT; fi; done
echo "Hacking together a MacOS application..."
mkdir -p "$HOME"/mu-editor.app/Contents/Resources
mkdir -p "$HOME"/mu-editor.app/Contents/MacOS
cp "$HOST"/Info.plist "$HOME"/mu-editor.app/Contents
cp "$HOST"/mu-editor.icns "$HOME"/mu-editor.app/Contents/Resources
# Copy Python over...
cp -r "$BUILD_OUT" "$HOME"/mu-editor.app/Contents/Resources


echo '#!/bin/sh' > "$HOME"/mu-editor.app/Contents/MacOS/mu-editor
echo "" >> "$HOME"/mu-editor.app/Contents/MacOS/mu-editor
# echo "echo OIOIOI" >> $HOME/mu-editor.app/Contents/MacOS/mu-editor
echo "/Applications/mu-editor.app/Contents/Resources/python/bin/mu-editor" >> "$HOME"/mu-editor.app/Contents/MacOS/mu-editor
chmod u+x "$HOME"/mu-editor.app/Contents/MacOS/mu-editor

echo "That should be it..."

echo "Building a DMG"
#TODO!
# Have a look at this one: https://github.com/andreyvit/create-dmg

echo "Compressing DMG"
#TODO!
#mkdir upload
#tar czf upload/python$VERSIONMINOR-full.tar.gz $BUILD_OUT
tar -cjf mu-editor.tar.bz2 mu-editor.app
du -sk "$HOME"/mu-editor.tar.bz2

# That is forbidden, why? -> Mount host dir to under $HOME
mv mu-editor.tar.bz2 "$HOME"/host

mv "$HOME"/mu-editor.app /Applications

echo "source /Applications/mu-editor.app/Contents/Resources/python/bin/mu_env.sh" >> ~/.bash_profile

# curl --upload-file ./upload/python3-full.tar.gz https://transfer.sh/python3-full.tar.gz | tee -a output_urls.txt && echo "" >> output_urls.txt



#   # Reduce stand-alone Python and upload it
#   - cd "$PROJECT_DIR"
#   - python process_python_build.py "$PROJECT_DIR/python"
#   - echo "Python 3.6.5" >> ./python/version.txt
#   - tar czf upload/python3-reduced.tar.gz python/
#   - curl --upload-file ./upload/python3-reduced.tar.gz https://transfer.sh/python3-reduced.tar.gz | tee -a output_urls.txt && echo "" >> output_urls.txt
