class Page {
  int? totalDocs;
  int? limit;
  int? totalPages;
  int? page;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  int? prevPage;
  int? nextPage;
  int? totalCount;
  int? pageSize;

  Page({
    this.totalDocs,
    this.limit = 10,
    this.totalPages,
    this.page = 1,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
    this.pageSize,
    this.totalCount,
  });

  Page.fromJson(Map<String, dynamic> json) {
    totalDocs = json['totalDocs'];
    limit = json['limit'];
    totalPages = json['totalPages'] ?? json['totalpage'];
    page = json['page'];
    pagingCounter = json['pagingCounter'];
    hasPrevPage = json['hasPrevPage'];
    hasNextPage = json['hasNextPage'];
    prevPage = json['prevPage'];
    nextPage = json['nextPage'];
  }
}
