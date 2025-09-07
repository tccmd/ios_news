class Article {
  final String? imgPath;
  final String? title;
  final String? description;
  final DateTime? publishedAt;
  final String? source;
  final String? category;

  const Article({
    this.imgPath,
    this.title,
    this.description,
    this.publishedAt,
    this.source,
    this.category,
  });

  /// "파이낸셜 타임스 · 9분 전" 형태로 변환하는 getter
  String get metaText {
    final now = DateTime.now();
    if (publishedAt == null) return source ?? '';
    final diff = now.difference(publishedAt!);

    String timeAgo;
    if (diff.inMinutes < 60) {
      timeAgo = '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      timeAgo = '${diff.inHours}시간 전';
    } else {
      timeAgo = '${diff.inDays}일 전';
    }

    return source != null ? '$source ·  $timeAgo' : timeAgo;
  }
}
