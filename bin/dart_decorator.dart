// приклад реалізації паттерну Декоратор у Dart на прикладі
// сценарію погодного додатку:

// Створіть інтерфейс або абстрактний клас, що визначає методи, які будуть
// реалізовувати декоратори та оригінальний об'єкт.

abstract class Weather {
  String getDescription();
  double getTemperature();
}

// Створіть конкретну реалізацію інтерфейсу або абстрактний клас, який
// представляє вихідний об'єкт.

class CurrentWeather implements Weather {
  final String _description;
  final double _temperature;

  CurrentWeather(this._description, this._temperature);

  @override
  String getDescription() {
    return _description;
  }

  @override
  double getTemperature() {
    return _temperature;
  }
}

// Створіть базовий клас-декоратор, який реалізує інтерфейс або абстрактний
// клас і має посилання на вихідний об'єкт.

class WeatherDecorator implements Weather {
  final Weather _weather;

  WeatherDecorator(this._weather);

  @override
  String getDescription() {
    return _weather.getDescription();
  }

  @override
  double getTemperature() {
    return _weather.getTemperature();
  }
}

// Створіть один або декілька конкретних класів-декораторів, які розширюють
// базовий клас-декоратор і додають нову поведінку до вихідного об'єкта.

class FahrenheitDecorator extends WeatherDecorator {
  FahrenheitDecorator(Weather weather) : super(weather);

  @override
  String getDescription() {
    return '${super.getDescription()} (in Fahrenheit)';
  }

  @override
  double getTemperature() {
    return (_weather.getTemperature() * 1.8) + 32;
  }
}

class HumidityDecorator extends WeatherDecorator {
  HumidityDecorator(Weather weather) : super(weather);

  @override
  String getDescription() {
    return '${super.getDescription()} with humidity';
  }

  String getHumidity() {
    return '40%';
  }
}

// Використовуйте декоратори, щоб додати нову поведінку до вихідного об'єкта.

void main() {
  // створюємо екземпляр погоди
  final currentWeather = CurrentWeather('Cloudy', 25.0);
  print(currentWeather.getDescription()); // output: Cloudy
  print(currentWeather.getTemperature()); // output: 25.0

  // використовуючи декоратор створюємо екземпляр тїєї ж погоди але в фаренгейтах
  final fahrenheitWeather = FahrenheitDecorator(currentWeather);
  print(fahrenheitWeather.getDescription()); // output: Cloudy (in Fahrenheit)
  print(fahrenheitWeather.getTemperature()); // output: 77.0

  // використовуючи декоратор створюємо екземпляр тїєї ж погоди але з додаванням вологості
  final humidWeather = HumidityDecorator(currentWeather);
  print(humidWeather.getDescription()); // output: Cloudy with humidity
  print(humidWeather.getHumidity()); // output: 40%

  // використовуючи декоратор створюємо екземпляр тїєї ж погоди але з додаванням
  // вологості та виводом температури у фаренгейтах
  final humidFahrenheitWeather =
      HumidityDecorator(FahrenheitDecorator(currentWeather));
  print(humidFahrenheitWeather
      .getDescription()); // output: Cloudy (in Fahrenheit) with humidity
  print(humidFahrenheitWeather.getTemperature()); // output: 77.0
  print(humidFahrenheitWeather.getHumidity()); // output: 40%
}


// У цьому прикладі оригінальний об'єкт CurrentWeather обгорнуто двома
// декораторами FahrenheitDecorator і HumidityDecorator, які додають нову
// поведінку до оригінального об'єкта, не впливаючи на його поведінку.
// FahrenheitDecorator перетворює температуру з градусів Цельсія в градуси
// Фаренгейта, а HumidityDecorator додає новий метод для отримання вологості.
// У виведенні показано, що декоратори викликаються у порядку їх додавання,
// а поведінка вихідного об'єкта викликається першою.