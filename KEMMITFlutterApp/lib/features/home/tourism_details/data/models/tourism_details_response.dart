class TourismDetailsResponse {
  String? id;
  String? reviewerName;
  String? comment;
  int? rating;
  String? dateReviewed;
  String? tourismPlaceId;
  String? applicationUserId;

  TourismDetailsResponse(
      {this.id,
      this.reviewerName,
      this.comment,
      this.rating,
      this.dateReviewed,
      this.tourismPlaceId,
      this.applicationUserId});

  TourismDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewerName = json['reviewerName'];
    comment = json['comment'];
    rating = json['rating'];
    dateReviewed = json['dateReviewed'];
    tourismPlaceId = json['tourismPlaceId'];
    applicationUserId = json['applicationUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reviewerName'] = reviewerName;
    data['comment'] = comment;
    data['rating'] = rating;
    data['dateReviewed'] = dateReviewed;
    data['tourismPlaceId'] = tourismPlaceId;
    data['applicationUserId'] = applicationUserId;
    return data;
  }
}
