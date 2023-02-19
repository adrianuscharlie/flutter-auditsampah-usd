class Report {
  String jenis = "";
  DateTime date = DateTime(2023);

  Report() {}
  Report.Complete(String jenis, DateTime date) {
    this.jenis = jenis;
    this.date = date;
  }
}
