/*
 * @Email: cavanvip@gmail.com
 * @Github: https://github.com/cavanlee
 * @Description: 
 */
enum EnvironmentEnum { product, develop }

class Environment {
  static EnvironmentEnum value = EnvironmentEnum.product;

  static String get mainNetwork => 'http://101.133.129.83:81';
  static String get testNetwork => 'http://101.133.129.83:81';

  static String get baseApiUrl {
    switch (value) {
      case EnvironmentEnum.product:
        return mainNetwork;
      default:
        return testNetwork;
    }
  }
}
