package models

import (
	"fmt"

	"gorm.io/driver/sqlserver"
	"gorm.io/gorm"
)

// Initial Database
var DB *gorm.DB

func ConnectToDatabase() {
	// Connect to SQL Server Database github.com/denisenkol0m/go-mssqldb
	dsn := "sqlserver://sa:password@KHIP01?database=db_Restaurant_Khip01&connection+timeout=30"
	database, err := gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
	if err != nil {
		fmt.Println(err.Error())
		// When error
		isError := true
		for isError {
			var username, password, host, databaseName, dsn string
			fmt.Println("\nMake sure you set the datasource on setup.go corectly!")
			fmt.Println("Set your dsn here")
			fmt.Print("Ex: sa\nYour Username: ")
			fmt.Scanln(&username)
			fmt.Print("Ex: password\nYour Password: ")
			fmt.Scanln(&password)
			fmt.Print("Ex: Khip01\nHost/Instance: ")
			fmt.Scanln(&host)
			fmt.Print("Ex: db_Restaurant_Khip01\nDatabase Name: ")
			fmt.Scanln(&databaseName)
			fmt.Println("Trying to connecting again\n")

			// Try to connect again
			dsn = fmt.Sprintf("sqlserver://%s:%s@%s?database=%s&connection+timeout=30", username, password, host, databaseName)
			database, err = gorm.Open(sqlserver.Open(dsn), &gorm.Config{})
			if err == nil {
				fmt.Println("Running on:\n" + dsn)
				isError = false
			} else {
				fmt.Print("Still can't reach the database you looking for, try again.\nLog: \n" + err.Error())
			}
		}

	}

	// Migrate ke database
	MigrateDatabase(database)

	// Store to var DB
	DB = database
}

func MigrateDatabase(db *gorm.DB) {
	db.AutoMigrate(&Menu{})
}
