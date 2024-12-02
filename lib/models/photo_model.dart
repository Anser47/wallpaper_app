// class PhotoModal {
//   final String id;
//   final String slug;
//   final Map<String, String> alternativeSlugs;
//   final String createdAt;
//   final String updatedAt;
//   final int width;
//   final int height;
//   final String color;
//   final String blurHash;
//   final String altDescription;
//   final Urls urls;

//   PhotoModal({
//     required this.id,
//     required this.slug,
//     required this.alternativeSlugs,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.width,
//     required this.height,
//     required this.color,
//     required this.blurHash,
//     required this.altDescription,
//     required this.urls,
//   });

//   factory PhotoModal.fromJson(Map<String, dynamic> json) {
//     return PhotoModal(
//       id: json['id'],
//       slug: json['slug'],
//       alternativeSlugs: Map.from(json['alternative_slugs']),
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       width: json['width'],
//       height: json['height'],
//       color: json['color'],
//       blurHash: json['blur_hash'],
//       altDescription: json['alt_description'] ?? '',
//       urls: Urls.fromJson(json['urls']),
//     );
//   }
// }

// class Urls {
//   final String raw;
//   final String full;
//   final String regular;
//   final String small;
//   final String thumb;
//   final String smallS3;

//   Urls({
//     required this.raw,
//     required this.full,
//     required this.regular,
//     required this.small,
//     required this.thumb,
//     required this.smallS3,
//   });

//   factory Urls.fromJson(Map<String, dynamic> json) {
//     return Urls(
//       raw: json['raw'],
//       full: json['full'],
//       regular: json['regular'],
//       small: json['small'],
//       thumb: json['thumb'],
//       smallS3: json['small_s3'],
//     );
//   }
// }
class UnsplashPhoto {
  final String id;
  final String? description;
  final UnsplashUrls urls;
  final String? altDescription;
  final int width;
  final int height;
  final int likes;

  UnsplashPhoto({
    required this.id,
    this.description,
    required this.urls,
    this.altDescription,
    required this.width,
    required this.height,
    required this.likes,
  });

  factory UnsplashPhoto.fromJson(Map<String, dynamic> json) {
    return UnsplashPhoto(
      id: json['id'] ?? '',
      description: json['description'],
      urls: UnsplashUrls.fromJson(json['urls'] ?? {}),
      altDescription: json['alt_description'],
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      likes: json['likes'] ?? 0,
    );
  }
}

class UnsplashUrls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;

  UnsplashUrls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
  });

  factory UnsplashUrls.fromJson(Map<String, dynamic> json) {
    return UnsplashUrls(
      raw: json['raw'] ?? '',
      full: json['full'] ?? '',
      regular: json['regular'] ?? '',
      small: json['small'] ?? '',
      thumb: json['thumb'] ?? '',
    );
  }
}
