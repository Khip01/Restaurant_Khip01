package models

import (
	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
)

// Initial Database
var DB *gorm.DB

func ConnectToDatabase() {
	// Connect to SQL Server Database github.com/denisenkom/go-mssqldb
	dsn := "sqlserver://sa:password@KHIP01?database=db_Restaurant_Khip01&connection+timeout=30"
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		panic(err)
	}

	// Migrate ke database
	MigrateDatabase(database)

	// Store to var DB
	DB = database
}

func MigrateDatabase(db *gorm.DB) {
	db.AutoMigrate(&Menu{})
}
