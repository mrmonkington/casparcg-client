QT -= gui
QT += network

CONFIG += c++11

TARGET = tricaster
TEMPLATE = lib

DEFINES += TRICASTER_LIBRARY _GLIBCXX_USE_CXX11_ABI=1 QT_COMPILING_QSTRING_COMPAT_CPP

HEADERS += \
    TriCasterDevice.h \
    Shared.h \
    NtfcDevice.h
	
SOURCES += \
    TriCasterDevice.cpp \
    NtfcDevice.cpp
