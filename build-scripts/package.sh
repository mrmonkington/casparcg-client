#!/bin/sh

export BUILD_QT_PATH=/usr/bin
export BUILD_ARCHIVE_NAME="CasparCG Client"
export BUILD_PARALLEL_THREADS=8

fail()
{
    echo "$1" 1>&2
    exit 1
}

# Create client folder to later zip
export CLIENT_FOLDER="$BUILD_ARCHIVE_NAME"
if [ -f "$CLIENT_FOLDER" ]; then
    rm -Rf "$CLIENT_FOLDER" || fail "Could not delete $CLIENT_FOLDER"
fi
mkdir "$CLIENT_FOLDER" || fail "Could not create $CLIENT_FOLDER"
mkdir "$CLIENT_FOLDER/bin" || fail "Could not create $CLIENT_FOLDER/bin"
#mkdir "$CLIENT_FOLDER/lib" || fail "Could not create $CLIENT_FOLDER/lib"

# Copy compiled binaries
echo Copying binaries...
find . -name \*.so\* -exec cp -fP {} "$CLIENT_FOLDER/bin/" \; || fail "Could not copy client libraries"
cp -f Shell/shell "$CLIENT_FOLDER/bin/" || fail "Could not copy client executable"

# Copy binary dependencies
echo Copying binary dependencies...
cp -RfP ../deploy/linux/* "$CLIENT_FOLDER/" || fail "Could not copy binary dependencies"

# Copy documentation
echo Copying documentation...
cp -f ../CHANGELOG "$CLIENT_FOLDER/" || fail "Could not copy CHANGELOG"
cp -f ../LICENSE "$CLIENT_FOLDER/" || fail "Could not copy LICENSE"

# Create tar.gz file
echo Creating tag.gz...
tar -cvzf "$BUILD_ARCHIVE_NAME.tar.gz" "$CLIENT_FOLDER" || fail "Could not create archive"

