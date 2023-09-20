package menu_controller

import (
	"encoding/json"
	"net/http"

	"github.com/Khip01/Restaurant_Khip01/models"
	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// Get All Menus
func Menus(context *gin.Context) {
	// Create Slice for Dataset
	var menus []models.Menu

	// Find in database
	models.DB.Find(&menus)

	// Response show all menus
	context.JSON(http.StatusOK, gin.H{"All Menu": menus})
}

// Get One of the Menu
func GetMenu(context *gin.Context) {
	// Create Struct for Data
	var menu models.Menu

	// Catch the parameter Address Index
	id := context.Param("id")

	// Cari data di database beserta trycatch error
	err := models.DB.First(&menu, id).Error
	if err != nil {
		// Swtich error condition
		switch err {
		case gorm.ErrRecordNotFound:
			context.AbortWithStatusJSON(http.StatusNotFound, gin.H{"message": "Data Not Found"})
			return
		default:
			context.AbortWithStatusJSON(http.StatusInternalServerError, gin.H{"message": "Internal Server Error. Log: " + err.Error()})
			return
		}
	}

	// Success
	context.JSON(http.StatusOK, gin.H{"Menu": menu})
}

// Create Some Menu
func CreateMenu(context *gin.Context) {
	// Create Struct for Data
	var menu models.Menu

	// Catch User body Request
	err := context.ShouldBindJSON(&menu)
	if err != nil {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "Bad Request. Log: " + err.Error()})
		return
	}

	// Insert data to database
	models.DB.Create(&menu)

	// Response
	context.JSON(http.StatusOK, gin.H{"message": "Menu Inserted Successfully"})
}

// Update One of the Menu
func UpdateMenu(context *gin.Context) {
	// Create Struct for Data
	var menu models.Menu

	// Catch Parameter Address
	id := context.Param("id")

	// Catch User body Request
	err := context.ShouldBindJSON(&menu)
	if err != nil {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "Bad Request. Log: " + err.Error()})
		return
	}

	// Update the Menu and Try Catch Error
	catchError := models.DB.Model(&menu).Where("id = ?", id).Updates(&menu)
	if catchError.Error != nil {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "Bad Request. Log: " + err.Error()})
		return
	} else if catchError.RowsAffected == 0 {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "Bad Request, no data has changed"})
		return
	}

	// Success
	context.JSON(http.StatusOK, gin.H{"message": "Data Updated Successfully"})
}

// Delete One of the Menu
func DeleteMenu(context *gin.Context) {
	// Create Struct for Data
	var menu models.Menu

	// Create Other Struct for Storing Id
	var input struct {
		Id json.Number
	}

	// Catch Request body from user
	err := context.ShouldBindJSON(&input)
	if err != nil {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "Bad Request. Log: " + err.Error()})
		return
	}

	// Storing id in variable
	id, _ := input.Id.Int64()

	// Delete Data From Database
	rowsAffc := models.DB.Delete(&menu, id).RowsAffected
	if rowsAffc == 0 {
		context.AbortWithStatusJSON(http.StatusBadRequest, gin.H{"message": "No data is deleted"})
		return
	}

	// Success
	context.JSON(http.StatusOK, gin.H{"message": "Data Deleted Successfully!"})
}
