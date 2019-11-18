class PictureModel {
  String _picturePath;
  String _pictureHash;
  String _txHash;
  int _pictureTimestamp;

  PictureModel({
    String picturePath,
    String pictureHash,
    String txHash,
    int pictureTimestamp
  }): _picturePath = picturePath,
      _pictureHash = pictureHash,
      _txHash = txHash,
      _pictureTimestamp = pictureTimestamp;

  String get picturePath => _picturePath;
  String get pictureHash => _pictureHash;
  String get txHash => _txHash;
  int get pictureTimestamp => _pictureTimestamp;
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(_pictureTimestamp);

  PictureModel.fromJson(Map<String, dynamic> map) {
    _picturePath = map['picturePath'];
    _pictureHash = map['pictureHash'];
    _txHash = map['txHash'];
    _pictureTimestamp = map['pictureTimestamp'];
  }

  Map<String, dynamic> toJson() => {
    'picturePath': _picturePath,
    'pictureHash': _pictureHash,
    'txHash': _txHash,
    'pictureTimestamp': _pictureTimestamp
  };
}