import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:flutter/cupertino.dart';

class BMIProvider extends ChangeNotifier {
  late int _height;
  late int _weight;
  late int _age;
  late bool _isMale;
  late bool _isFemale = false;
  var gender;

  /// HEIGHT
  setIncrementHeight(int height) {
    notifyListeners();
    return _height++;
  }

  setDecrementHeight(int height) {
    notifyListeners();
    return _height--;
  }

  setSlideHeight(int height) {
    notifyListeners();
    return _height = height;
  }

  get getHeightBMI {
    return _height;
  }

  /// WEIGHT
  setIncrementWeight(int weight) {
    notifyListeners();
    return _weight++;
  }

  setDecrementWeight(int weight) {
    notifyListeners();
    return _weight--;
  }

  setSlideWeight(int weight) {
    notifyListeners();
    return _weight = weight;
  }

  get getWeightBMI {
    return _weight;
  }

  /// AGE
  setIncrementAge(int age) {
    notifyListeners();
    return _age++;
  }

  setDecrementAge(int age) {
    notifyListeners();
    return _age--;
  }

  setSlideAge(int age) {
    notifyListeners();
    return _age = age;
  }

  get getAgeBMI {
    return _age;
  }

  /// isFEMALE
  setIsFemale(bool isFemale) {
    notifyListeners();
    return _isFemale = isFemale;
  }

  get getisFemaleBMI {
    return _isFemale;
  }

  /// isMALE
  setIsMale(bool isMale) {
    notifyListeners();
    return _isMale = isMale;
  }

  get getisMaleBMI {
    return _isMale;
  }

  dataBMIInit() {
    _height = 100;
    _weight = 50;
    _age = 20;
    _isFemale = false;
    _isMale = false;
    gender = BMICalculatorProvider().gender;
  }
}
