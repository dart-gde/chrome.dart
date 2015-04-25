// Copyright 2014 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#include "extensions/common/api/bluetooth/bluetooth_manifest_permission.h"

#include "base/memory/scoped_ptr.h"
#include "base/stl_util.h"
#include "base/strings/utf_string_conversions.h"
#include "base/values.h"
#include "device/bluetooth/bluetooth_uuid.h"
#include "extensions/common/api/bluetooth/bluetooth_manifest_data.h"
#include "extensions/common/api/extensions_manifest_types.h"
#include "extensions/common/error_utils.h"
#include "extensions/common/manifest_constants.h"
#include "grit/extensions_strings.h"
#include "ipc/ipc_message.h"
#include "ui/base/l10n/l10n_util.h"

namespace extensions {

namespace bluetooth_errors {
const char kErrorInvalidUuid[] = "Invalid UUID '*'";
}

namespace errors = bluetooth_errors;

namespace {

bool ParseUuid(BluetoothManifestPermission* permission,
               const std::string& uuid,
               base::string16* error) {
  device::BluetoothUUID bt_uuid(uuid);
  if (!bt_uuid.IsValid()) {
    *error = ErrorUtils::FormatErrorMessageUTF16(
        errors::kErrorInvalidUuid, uuid);
    return false;
  }
  permission->AddPermission(uuid);
  return true;
}

bool ParseUuidArray(BluetoothManifestPermission* permission,
                    const scoped_ptr<std::vector<std::string> >& uuids,
                    base::string16* error) {
  for (std::vector<std::string>::const_iterator it = uuids->begin();
       it != uuids->end();
       ++it) {
    if (!ParseUuid(permission, *it, error)) {
      return false;
    }
  }
  return true;
}

}  // namespace

BluetoothManifestPermission::BluetoothManifestPermission()
  : socket_(false),
    low_energy_(false) {}

BluetoothManifestPermission::~BluetoothManifestPermission() {}

// static
scoped_ptr<BluetoothManifestPermission> BluetoothManifestPermission::FromValue(
    const base::Value& value,
    base::string16* error) {
  scoped_ptr<core_api::extensions_manifest_types::Bluetooth> bluetooth =
      core_api::extensions_manifest_types::Bluetooth::FromValue(value, error);
  if (!bluetooth)
    return scoped_ptr<BluetoothManifestPermission>();

  scoped_ptr<BluetoothManifestPermission> result(
      new BluetoothManifestPermission());
  if (bluetooth->uuids) {
    if (!ParseUuidArray(result.get(), bluetooth->uuids, error)) {
      return scoped_ptr<BluetoothManifestPermission>();
    }
  }
  if (bluetooth->socket) {
    result->socket_ = *(bluetooth->socket);
  }
  if (bluetooth->low_energy) {
    result->low_energy_ = *(bluetooth->low_energy);
  }
  return result.Pass();
}

bool BluetoothManifestPermission::CheckRequest(
    const Extension* extension,
    const BluetoothPermissionRequest& request) const {

  device::BluetoothUUID param_uuid(request.uuid);
  for (BluetoothUuidSet::const_iterator it = uuids_.begin();
       it != uuids_.end();
       ++it) {
    device::BluetoothUUID uuid(*it);
    if (param_uuid == uuid)
      return true;
  }
  return false;
}

bool BluetoothManifestPermission::CheckSocketPermitted(
    const Extension* extension) const {
  return socket_;
}

bool BluetoothManifestPermission::CheckLowEnergyPermitted(
    const Extension* extension) const {
  return low_energy_;
}

std::string BluetoothManifestPermission::name() const {
  return manifest_keys::kBluetooth;
}

std::string BluetoothManifestPermission::id() const { return name(); }

PermissionIDSet BluetoothManifestPermission::GetPermissions() const {
  PermissionIDSet permissions;
  // TODO(sashab): Add a rule to ChromePermissionMessageProvider:
  // kBluetooth -> IDS_EXTENSION_PROMPT_WARNING_BLUETOOTH
  permissions.insert(APIPermission::kBluetooth);
  if (!uuids_.empty()) {
    // TODO(sashab): Add a rule to ChromePermissionMessageProvider:
    // kBluetoothDevices -> IDS_EXTENSION_PROMPT_WARNING_BLUETOOTH_DEVICES
    permissions.insert(APIPermission::kBluetoothDevices);
  }
  return permissions;
}

bool BluetoothManifestPermission::HasMessages() const { return true; }

PermissionMessages BluetoothManifestPermission::GetMessages() const {
  // When modifying this function, be careful to also modify GetPermissions()
  // above to have the same functionality.
  DCHECK(HasMessages());
  PermissionMessages result;

  result.push_back(PermissionMessage(
      PermissionMessage::kBluetooth,
      l10n_util::GetStringUTF16(IDS_EXTENSION_PROMPT_WARNING_BLUETOOTH)));

  if (!uuids_.empty()) {
    result.push_back(
        PermissionMessage(PermissionMessage::kBluetoothDevices,
                          l10n_util::GetStringUTF16(
                              IDS_EXTENSION_PROMPT_WARNING_BLUETOOTH_DEVICES)));
  }

  return result;
}

bool BluetoothManifestPermission::FromValue(const base::Value* value) {
  if (!value)
    return false;
  base::string16 error;
  scoped_ptr<BluetoothManifestPermission> manifest_permission(
      BluetoothManifestPermission::FromValue(*value, &error));

  if (!manifest_permission)
    return false;

  uuids_ = manifest_permission->uuids_;
  return true;
}

scoped_ptr<base::Value> BluetoothManifestPermission::ToValue() const {
  core_api::extensions_manifest_types::Bluetooth bluetooth;
  bluetooth.uuids.reset(new std::vector<std::string>(uuids_.begin(),
                                                     uuids_.end()));
  return bluetooth.ToValue().Pass();
}

ManifestPermission* BluetoothManifestPermission::Diff(
    const ManifestPermission* rhs) const {
  const BluetoothManifestPermission* other =
      static_cast<const BluetoothManifestPermission*>(rhs);

  scoped_ptr<BluetoothManifestPermission> result(
      new BluetoothManifestPermission());
  result->uuids_ = base::STLSetDifference<BluetoothUuidSet>(
      uuids_, other->uuids_);
  return result.release();
}

ManifestPermission* BluetoothManifestPermission::Union(
    const ManifestPermission* rhs) const {
  const BluetoothManifestPermission* other =
      static_cast<const BluetoothManifestPermission*>(rhs);

  scoped_ptr<BluetoothManifestPermission> result(
      new BluetoothManifestPermission());
  result->uuids_ = base::STLSetUnion<BluetoothUuidSet>(
      uuids_, other->uuids_);
  return result.release();
}

ManifestPermission* BluetoothManifestPermission::Intersect(
    const ManifestPermission* rhs) const {
  const BluetoothManifestPermission* other =
      static_cast<const BluetoothManifestPermission*>(rhs);

  scoped_ptr<BluetoothManifestPermission> result(
      new BluetoothManifestPermission());
  result->uuids_ = base::STLSetIntersection<BluetoothUuidSet>(
      uuids_, other->uuids_);
  return result.release();
}

void BluetoothManifestPermission::AddPermission(const std::string& uuid) {
  uuids_.insert(uuid);
}

}  // namespace extensions
