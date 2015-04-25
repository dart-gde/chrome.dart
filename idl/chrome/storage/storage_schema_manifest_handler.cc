// Copyright 2013 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "chrome/common/extensions/api/storage/storage_schema_manifest_handler.h"

#include <string>
#include <vector>

#include "base/files/file_path.h"
#include "base/files/file_util.h"
#include "base/memory/scoped_ptr.h"
#include "base/strings/string16.h"
#include "base/strings/stringprintf.h"
#include "base/strings/utf_string_conversions.h"
#include "extensions/common/extension.h"
#include "extensions/common/install_warning.h"
#include "extensions/common/manifest.h"
#include "extensions/common/manifest_constants.h"
#include "extensions/common/manifest_handlers/permissions_parser.h"
#include "extensions/common/permissions/api_permission.h"
#include "extensions/common/permissions/api_permission_set.h"
#include "extensions/common/permissions/permissions_info.h"

#if defined(ENABLE_CONFIGURATION_POLICY)
#include "components/policy/core/common/schema.h"
#endif

using extensions::manifest_keys::kStorageManagedSchema;

namespace extensions {

StorageSchemaManifestHandler::StorageSchemaManifestHandler() {}

StorageSchemaManifestHandler::~StorageSchemaManifestHandler() {}

#if defined(ENABLE_CONFIGURATION_POLICY)
// static
policy::Schema StorageSchemaManifestHandler::GetSchema(
    const Extension* extension,
    std::string* error) {
  std::string path;
  extension->manifest()->GetString(kStorageManagedSchema, &path);
  base::FilePath file = base::FilePath::FromUTF8Unsafe(path);
  if (file.IsAbsolute() || file.ReferencesParent()) {
    *error = base::StringPrintf("%s must be a relative path without ..",
                                kStorageManagedSchema);
    return policy::Schema();
  }
  file = extension->path().AppendASCII(path);
  if (!base::PathExists(file)) {
    *error =
        base::StringPrintf("File does not exist: %s", file.value().c_str());
    return policy::Schema();
  }
  std::string content;
  if (!base::ReadFileToString(file, &content)) {
    *error = base::StringPrintf("Can't read %s", file.value().c_str());
    return policy::Schema();
  }
  return policy::Schema::Parse(content, error);
}
#endif

bool StorageSchemaManifestHandler::Parse(Extension* extension,
                                         base::string16* error) {
  std::string path;
  if (!extension->manifest()->GetString(kStorageManagedSchema, &path)) {
    *error = base::ASCIIToUTF16(
        base::StringPrintf("%s must be a string", kStorageManagedSchema));
    return false;
  }

  // If an extension declares the "storage.managed_schema" key then it gets
  // the "storage" permission implicitly.
  PermissionsParser::AddAPIPermission(extension, APIPermission::kStorage);

  return true;
}

bool StorageSchemaManifestHandler::Validate(
    const Extension* extension,
    std::string* error,
    std::vector<InstallWarning>* warnings) const {
#if defined(ENABLE_CONFIGURATION_POLICY)
  return GetSchema(extension, error).valid();
#else
  return true;
#endif
}

const std::vector<std::string> StorageSchemaManifestHandler::Keys() const {
  return SingleKey(kStorageManagedSchema);
}

}  // namespace extensions
