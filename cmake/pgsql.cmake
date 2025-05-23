# - Find pq
# Find the native PGSQL includes and library
#
#  PGSQL_INCLUDE_DIR - where to find libpq-fe.h, etc.
#  PGSQL_LIBRARIES   - List of libraries when using PGSQL.
#  PGSQL_FOUND       - True if PGSQL found.

IF (PGSQL_INCLUDE_DIR)
  # Already in cache, be silent
  SET(PGSQL_FIND_QUIETLY TRUE)
ENDIF (PGSQL_INCLUDE_DIR)

IF (WIN32)
  FIND_PATH(PGSQL_INCLUDE_DIR libpq-fe.h
    $ENV{PROGRAMFILES}/PostgreSQL/*/include
    $ENV{SYSTEMDRIVE}/PostgreSQL/*/include)
ELSEIF (LINUX)
  FIND_PATH(PGSQL_INCLUDE_DIR libpq-fe.h
    /usr/local/include/postgresql
    /usr/include/postgresql)
ELSEIF (APPLE)
  FIND_PATH(PGSQL_INCLUDE_DIR libpq-fe.h
    /opt/homebrew/include/postgresql)
ELSE (WIN32)
  FIND_PATH(PGSQL_INCLUDE_DIR libpq-fe.h
    /opt/homebrew/include/postgresql
    /usr/local/include/postgresql
    /usr/include/postgresql)
ENDIF()

IF (WIN32)
  SET(PGSQL_NAMES libpq)
  FIND_LIBRARY(PGSQL_LIBRARY
    NAMES ${PGSQL_NAMES}
    PATHS $ENV{PROGRAMFILES}/PostgreSQL/*/lib 
    $ENV{SYSTEMDRIVE}/PostgreSQL/*/lib)
ELSEIF (LINUX)
  SET(PGSQL_NAMES pq)
  FIND_LIBRARY(PGSQL_LIBRARY
    NAMES ${PGSQL_NAMES}
    PATHS /usr/lib 
    /usr/local/lib)
ELSEIF (APPLE)
  SET(PGSQL_NAMES pq)
  FIND_LIBRARY(PGSQL_LIBRARY
    NAMES ${PGSQL_NAMES}
    PATHS /opt/homebrew/lib)
ELSE (WIN32)
  SET(PGSQL_NAMES pq)
  FIND_LIBRARY(PGSQL_LIBRARY
    NAMES ${PGSQL_NAMES}
    PATHS /usr/lib
    /usr/local/lib
    /opt/homebrew/lib)
ENDIF()

IF (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)
  SET(PGSQL_FOUND TRUE)
  SET(PGSQL_LIBRARIES ${PGSQL_LIBRARY})
ELSE (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)
  SET(PGSQL_FOUND FALSE)
  SET(PGSQL_LIBRARIES)
ENDIF (PGSQL_INCLUDE_DIR AND PGSQL_LIBRARY)

IF (PGSQL_FOUND)
  IF (NOT PGSQL_FIND_QUIETLY)
    MESSAGE(STATUS "Found PGSQL: ${PGSQL_LIBRARY}")
  ENDIF (NOT PGSQL_FIND_QUIETLY)
ELSE (PGSQL_FOUND)
  IF (PGSQL_FIND_REQUIRED)
    MESSAGE(STATUS "Looked for PGSQL libraries named ${PGSQL_NAMES}.")
    MESSAGE(FATAL_ERROR "Could NOT find PGSQL library")
  ENDIF (PGSQL_FIND_REQUIRED)
ENDIF (PGSQL_FOUND)

MARK_AS_ADVANCED(PGSQL_LIBRARY PGSQL_INCLUDE_DIR)