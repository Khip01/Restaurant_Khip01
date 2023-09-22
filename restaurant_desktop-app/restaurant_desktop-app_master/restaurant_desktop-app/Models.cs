using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace restaurant_desktop_app
{
    // Menu Class inside the All Menu Array (ALL MENU)
    /*
       {
            "All Menu": [
                {
                    "id": 1,
                    "menu_name": "Kare Ayam Gurih Nyoy",
                    "description": "Enak, murah meriah",
                    "price": 10000
                }
                .
                .
                . so on
            ]
        }
     */
    public class MenuResponse
    {
        [JsonProperty("All Menu")]
        public List<Menu> AllMenu { get; set; }
    }

    // Menu Class inside the Menu Object
    /*
       {
            "Menu": {
                "id": 1,
                "menu_name": "Kare Ayam Gurih Nyoy",
                "description": "Enak, murah meriah",
                "price": 10000
            }
       }
     */
    public class MenuWrapper
    {
        [JsonProperty("Menu")]
        public Menu Menu { get; set; }
    }

    // Class JSON as Menu
    public class Menu
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("menu_name")]
        public string MenuName { get; set; }

        [JsonProperty("description")]
        public string Description { get; set; }

        [JsonProperty("price")]
        public int Price { get; set; }
    }
}
