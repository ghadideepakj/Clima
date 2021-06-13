
![App Brewery Banner](Documentation/AppBreweryBanner.png)

#  Clima 
This is created under guidance of App Brewery course
Check gif files for demonstration

## What you will See

* Parsed JSON with the native Encodable and Decodable protocols. 
* Used Core Location to get the current location from the phone GPS. 
* Get temperature of any city you want by entering city name.
* A descent UI as far as I think.

### Condition Codes
```
switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
```

>This is a companion project to The App Brewery's Complete App Development Bootcamp, check out the full course at [www.appbrewery.co](https://www.appbrewery.co/)

![End Banner](Documentation/readme-end-banner.png)
