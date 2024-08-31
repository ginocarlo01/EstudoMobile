class Tip {
  final double _defaultTip = 10.0;
  double? _customTip;
  double? _totalAmount;

  Tip() {
    _customTip = 10;
  }

  Tip.withData({double customTip = 10, double totalAmount = 30}) {
    _customTip = customTip;
    _totalAmount = totalAmount;
  }

  String get customTip {
    return (_customTip ?? 0).toStringAsFixed(2);
  }

  String get defaultTip {
    return _defaultTip.toStringAsFixed(2);
  }

  String get amount {
    return (_totalAmount ?? 0).toStringAsFixed(2);
  }

  String get defaultTippedAmount {
    return ((_totalAmount ?? 0) * _defaultTip / 100).toStringAsFixed(2);
  }

  String get amountPlusDefaultTippedAmount {
    if (_totalAmount == null) {
      return (0).toStringAsFixed(2);
    }
    return (_totalAmount! * (1 + _defaultTip / 100)).toStringAsFixed(2);
  }

  String get customTippedAmount {
    return ((_totalAmount ?? 0) * (_customTip ?? 0) / 100).toStringAsFixed(2);
  }

  String get amountPlusCustomTippedAmount {
    if (_totalAmount == null) {
      return (0).toStringAsFixed(2);
    }
    return (_totalAmount! * (1 + _customTip! / 100)).toStringAsFixed(2);
  }

  set amount(String value) {
    try {
      _totalAmount = double.parse(value);
    } catch (e) {
      _totalAmount = 0;
    }
  }

  set customTip(String value) {
    try {
      _customTip = double.parse(value);
    } catch (e) {
      _customTip = 0;
    }
  }
}
