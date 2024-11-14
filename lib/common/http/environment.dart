/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */
enum EnvironmentEnum { product, develop }

class Environment {
  static EnvironmentEnum value = EnvironmentEnum.product;

  static String get mainNetwork => 'http://54.67.115.49:8088';
  static String get testNetwork => 'http://54.67.115.49:8088';

  static String get baseApiUrl {
    switch (value) {
      case EnvironmentEnum.product:
        return mainNetwork;
      default:
        return testNetwork;
    }
  }
}
