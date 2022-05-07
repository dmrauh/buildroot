################################################################################
#
# gdal
#
################################################################################

GDAL_VERSION = 3.4.3
GDAL_SITE = https://download.osgeo.org/gdal/$(GDAL_VERSION)
GDAL_SOURCE = gdal-$(GDAL_VERSION).tar.xz
GDAL_LICENSE = MIT (GDAL/OGR), BSD-3-Clause, APACHE-2.0
GDAL_LICENSE_FILES = LICENSE.TXT PROVENANCE.TXT
GDAL_INSTALL_STAGING = YES
GDAL_CONFIG_SCRIPTS = gdal-config
# gdal at its core only needs host-pkgconf, libgeotiff, proj and tiff but since
# by default mrf driver support is enabled, it also needs jpeg, libpng and
# zlib. By default there are also many other drivers enabled but it seems, in
# contrast to mrf driver support, that they can be implicitly disabled, by
# configuring gdal without their respectively needed dependencies.
GDAL_DEPENDENCIES = host-pkgconf jpeg libgeotiff libpng proj tiff zlib

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
GDAL_DEPENDENCIES += postgresql
GDAL_CONF_OPTS += --with-pg
else
GDAL_CONF_OPTS += --without-pg
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
GDAL_DEPENDENCIES += libxml2
GDAL_CONF_OPTS += --with-xml2
else
GDAL_CONF_OPTS += --without-xml2
endif

GDAL_CONF_OPTS += \
	--with-geotiff \
	--with-libjson-c \
	--with-libtiff \
	--with-libtool \
	--with-libz \
	--with-jpeg \
	--with-png \
	--with-proj

# disable not yet handled packages and thus their associated gdal drivers
GDAL_CONF_OPTS += \
	--without-armadillo \
	--without-blosc \
	--without-brunsli \
	--without-cfitsio \
	--without-crypto \
	--without-cryptopp \
	--without-curl \
	--without-dds \
	--without-dods-root \
	--without-ecw \
	--without-expat \
	--without-exr \
	--without-fgdb \
	--without-fme \
	--without-freexl \
	--without-geos \
	--without-gnm \
	--without-libkml \
	--without-lz4 \
	--without-grass \
	--without-libgrass \
	--without-gta \
	--without-hdf4 \
	--without-hdf5 \
	--without-hdfs \
	--without-heif \
	--without-idb \
	--without-ingres \
	--without-jp2lura \
	--without-jasper \
	--without-java \
	--without-jpeg12 \
	--without-jxl \
	--without-charls \
	--without-kakadu \
	--without-kea \
	--without-lerc \
	--without-gif \
	--without-liblzma \
	--without-libdeflate \
	--without-mdb \
	--without-mongocxx \
	--without-mongocxxv3 \
	--without-mrsid \
	--without-jp2mrsid \
	--without-macosx-framework \
	--without-mrsid_lidar \
	--without-msg \
	--without-mysql \
	--without-netcdf \
	--without-null \
	--without-oci \
	--without-odbc \
	--without-ogdi \
	--without-opencl \
	--without-openjpeg \
	--without-pam \
	--without-pcidsk \
	--without-pcraster \
	--without-pcre \
	--without-pcre2 \
	--without-pdfium \
	--without-perl \
	--without-podofo \
	--without-poppler \
	--without-python \
	--without-qhull \
	--without-rasdaman \
	--without-rasterlite2 \
	--without-rdb \
	--without-sfcgal \
	--without-sosi \
	--without-spatialite \
	--without-sqlite3 \
	--without-teigha \
	--without-tiledb \
	--without-webp \
	--without-xerces \
	--without-zstd

$(eval $(autotools-package))
