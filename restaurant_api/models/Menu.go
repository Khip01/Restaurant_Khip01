package models

type Menu struct {
	Id          int64  `gorm:"primaryKey" json:"id"`
	MenuName    string `gorm:"type:varchar(300);not null;default:null" json:"menu_name"`
	Description string `gorm:"type:text" json:"description"`
	Price       int    `gorm:"type:int;not null;default:null" json:"price"`
}

// Return Custom Table Name
func (Menu) TableName() string {
	return "tblMenu"
}
