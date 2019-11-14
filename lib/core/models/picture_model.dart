class PictureModel {
  String _picturePath;
  String _pictureHash;
  String _txHash;

  PictureModel({
    String picturePath,
    String pictureHash,
    String txHash
  }): _picturePath = picturePath, _pictureHash = pictureHash, _txHash = txHash;

  String get picturePath => _picturePath;
  String get pictureHash => _pictureHash;
  String get txHash => _txHash;

  PictureModel.fromJson(Map<String, dynamic> map) {
    _picturePath = map['picturePath'];
    _pictureHash = map['pictureHash'];
    _txHash = map['txHash'];
  }

  Map<String, dynamic> toJson() => {
    'picturePath': _picturePath,
    'pictureHash': _pictureHash,
    'txHash': _txHash
  };
}