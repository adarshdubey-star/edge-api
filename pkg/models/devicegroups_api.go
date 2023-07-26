package models

// CreateDeviceGroupAPI is the /device-group POST endpoint struct for openapi.json auto-gen
type CreateDeviceGroupAPI struct {
	Name    string                    `json:"name" example:"my-device-group"` // the device group name
	Type    string                    `json:"type" example:"static"`          // the device group type
	Devices []DeviceForDeviceGroupAPI `json:"DevicesAPI,omitempty"`           // Devices of group

} // CreateDeviceGroup

// DeviceImageInfoAPI is a record of group with the current images running on the device
type DeviceImageInfoAPI struct {
	Name            string `json:"name" example:"my-image-name"`
	Version         int    `json:"version" example:"1"`
	Distribution    string `json:"distribution" example:"RHEL-92"`
	UpdateAvailable bool   `json:"update Available" example:"true"`
	CommitID        uint   `json:"commitID" example:"2"`
} // DeviceImage

// DeviceForDeviceGroupAPI is a device array expected to create groups with devices
type DeviceForDeviceGroupAPI struct {
	UUID string `json:"UUID" example:"68485bb8-6427-40ad-8711-93b6a5b4deac"`
} // Device

// DeviceGroupDevicesAPI is the /device-group return endpoint struct for openapi.json auto-gen
type DeviceGroupDevicesAPI struct {
	Account     string `json:"Account"`
	OrgID       string `json:"org_id"`
	Name        string `json:"Name"`
	Type        string `json:"Type"`
	ValidUpdate bool   `json:"ValidUpdate" `
} // DeviceGroup