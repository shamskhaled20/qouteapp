class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }
}

class QuoteResponse {
  final List<Quote> quotes;
  final int total;
  final int skip;
  final int limit;

  QuoteResponse({
    required this.quotes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory QuoteResponse.fromJson(Map<String, dynamic> json) {
    return QuoteResponse(
      quotes: List<Quote>.from(json['quotes'].map((quote) => Quote.fromJson(quote))),
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}
