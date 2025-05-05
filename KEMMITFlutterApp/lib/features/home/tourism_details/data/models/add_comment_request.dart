class AddCommentRequest {
  final String reviewerName;
  final String comment;
  final int rating;
  final String dateReviewed;
  final String tourismPlaceId;
  final String userId;

  AddCommentRequest({
    required this.reviewerName,
    required this.comment,
    required this.rating,
    required this.dateReviewed,
    required this.tourismPlaceId,
    required this.userId,
  });

  factory AddCommentRequest.fromJson(Map<String, dynamic> json) {
    return AddCommentRequest(
      reviewerName: json['reviewerName'],
      comment: json['comment'],
      rating: json['rating'],
      dateReviewed: json['dateReviewed'],
      tourismPlaceId: json['tourismPlaceId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reviewerName'] = reviewerName;
    data['comment'] = comment;
    data['rating'] = rating;
    data['dateReviewed'] = dateReviewed;
    data['tourismPlaceId'] = tourismPlaceId;
    data['userId'] = userId;
    return data;
  }
}
