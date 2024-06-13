class Apis {
  static const String apikey = 'fc1ad74921dd49dea95a761565f6e3e5';
  //"99eba290233e41f2b36d5c55d72d70bc";
  static getHeadline(final String query) => "https://newsapi.org/v2/top-headlines?q=$query&apiKey=$apikey";
  static getEverythingbyPopularity(final String query) =>
      "https://newsapi.org/v2/everything?q=$query&sortBy=popularity&apiKey=$apikey";
  static getHeadlinebyCountry(final String country) => "https://newsapi.org/v2/top-headlines?country=$country&apiKey=$apikey";
  static const String getEverythingbyDomain =
      "https://newsapi.org/v2/everything?domains=techcrunch.com,thenextweb.com&apiKey=$apikey";

  static String getHeadLineBySource(final String category) =>
      "https://newsapi.org/v2/top-headlines?category=$category&apiKey=$apikey";
}
