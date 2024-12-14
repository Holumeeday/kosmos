enum ErrorEnum {
  timeout('timeout'),
  connection('connection'),
  unknown('unknown'),
  cancel('cancel'),
  unavailable('unavailable'),
  responseError('responseError');

  final String detail;
  const ErrorEnum(this.detail);
}
