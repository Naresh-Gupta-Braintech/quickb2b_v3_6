class BannerModel {
  String? link;
  String? text;
  BannerModel({required this.link, required this.text});
}

List<BannerModel> bannerList = [
  BannerModel(
    link: "https://develop.quickb2b.com/files/app-banner/QuickB2B_Develop/1728691503400x120-meat.png",
    text: """ <p><span style="font-size:16px"><span style="font-family:trebuchet ms,helvetica,sans-serif"><span style="color:#FFFFFF"><span style="background-color:#000000">&nbsp;Get it First, get it Fresh&nbsp;</span></span></span></span></p>""",
  ),
  BannerModel(
    link: "https://develop.quickb2b.com/files/app-banner/QuickB2B_Develop/1728691508400x120-meat.png",
    text: """ <p><span style="font-size:16px"><span style="font-family:trebuchet ms,helvetica,sans-serif"><span style="color:#FFFFFF"><span style="background-color:#000000">&nbsp;Fresh Cut Fruit &amp; Veg&nbsp;<br />\r\n&nbsp;prepared&nbsp;every day&nbsp;</span></span></span></span></p>""",
  ),
  BannerModel(
    link: "https://develop.quickb2b.com/files/app-banner/QuickB2B_Develop/1728691510400x120-meat.png",
    text:
        """     <p><span style="font-size:16px"><span style="color:#FFFFFF"><span style="font-family:trebuchet ms,helvetica,sans-serif"><span style="background-color:#000000">&nbsp;Top Quality Grain Fed Beef&nbsp;</span></span>></span>></span>><\/p>\r\n\r\n<p><span style="font-size:16px"><span style="color:#FFFFFF"><span style="font-family:trebuchet ms,helvetica,sans-serif"><span style="background-color:#000000">&nbsp;now available&nbsp;</span>></span>></span>></span>></p>""",
  ),
];
