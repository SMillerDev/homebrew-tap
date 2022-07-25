class Dispatch < Formula
  include Language::Python::Virtualenv

  desc "All of the ad-hoc things you're doing to manage incidents today, done for you!"
  homepage "https://github.com/Netflix/dispatch"
  url "https://github.com/Netflix/dispatch/archive/refs/tags/v20220706.tar.gz"
  sha256 "c4bc42b145a1e25536ba8f2774ac285457561cc87eceadbd51cc20f3bcc8c6d3"
  license "Apache-2.0"

  depends_on "rust" => :build
  depends_on "jinja2-cli"
  depends_on "node"
  depends_on "python@3.10"
  depends_on "six"

  # resource aiofiles==0.8.0
  resource "aiofiles" do
    url "https://files.pythonhosted.org/packages/10/ca/c416cfacf6a47e1400dad56eab85aa86c92c6fbe58447d12035e434f0d5c/aiofiles-0.8.0.tar.gz"
    sha256 "8334f23235248a3b2e83b2c3a78a22674f39969b96397126cc93664d9a901e59"
  end
  # resource aiohttp==3.8.1
  resource "aiohttp" do
    url "https://files.pythonhosted.org/packages/5a/86/5f63de7a202550269a617a5d57859a2961f3396ecd1739a70b92224766bc/aiohttp-3.8.1.tar.gz"
    sha256 "fc5471e1a54de15ef71c1bc6ebe80d4dc681ea600e68bfd1cbce40427f0b7578"
  end
  # resource aiosignal==1.2.0
  resource "aiosignal" do
    url "https://files.pythonhosted.org/packages/27/6b/a89fbcfae70cf53f066ec22591938296889d3cc58fec1e1c393b10e8d71d/aiosignal-1.2.0.tar.gz"
    sha256 "78ed67db6c7b7ced4f98e495e572106d5c432a93e1ddd1bf475e1dc05f5b7df2"
  end
  # resource alembic==1.7.7
  resource "alembic" do
    url "https://files.pythonhosted.org/packages/30/b9/5526b43a4c54d177ab14af0af4b5c31d73db33d1ad3e30976d3b023e0594/alembic-1.7.7.tar.gz"
    sha256 "4961248173ead7ce8a21efb3de378f13b8398e6630fab0eb258dc74a8af24c58"
  end
  # resource anyio==3.5.0
  resource "anyio" do
    url "https://files.pythonhosted.org/packages/4f/d0/b957c0679a9bd0ed334e2e584102f077c3e703f83d099464c3d9569b7c8a/anyio-3.5.0.tar.gz"
    sha256 "a0aeffe2fb1fdf374a8e4b471444f0f3ac4fb9f5a5b542b48824475e0042a5a6"
  end
  # resource asgiref==3.5.0
  resource "asgiref" do
    url "https://files.pythonhosted.org/packages/ea/2b/3face3a7241f61dc1c58dbe243cc02c15c61ccdcafebc4406f7bb40ce731/asgiref-3.5.0.tar.gz"
    sha256 "2f8abc20f7248433085eda803936d98992f1343ddb022065779f37c5da0181d0"
  end
  # resource async-timeout==4.0.2
  resource "async-timeout" do
    url "https://files.pythonhosted.org/packages/54/6e/9678f7b2993537452710ffb1750c62d2c26df438aa621ad5fa9d1507a43a/async-timeout-4.0.2.tar.gz"
    sha256 "2163e1640ddb52b7a8c80d0a67a08587e5d245cc9c553a74a847056bc2976b15"
  end
  # resource attrs==21.4.0
  resource "attrs" do
    url "https://files.pythonhosted.org/packages/d7/77/ebb15fc26d0f815839ecd897b919ed6d85c050feeb83e100e020df9153d2/attrs-21.4.0.tar.gz"
    sha256 "626ba8234211db98e869df76230a137c4c40a12d72445c45d5f5b716f076e2fd"
  end
  # resource bcrypt==3.2.0
  resource "bcrypt" do
    url "https://files.pythonhosted.org/packages/d8/ba/21c475ead997ee21502d30f76fd93ad8d5858d19a3fad7cd153de698c4dd/bcrypt-3.2.0.tar.gz"
    sha256 "5b93c1726e50a93a033c36e5ca7fdcd29a5c7395af50a6892f5d9e7c6cfbfb29"
  end
  # resource blis==0.7.7
  resource "blis" do
    url "https://files.pythonhosted.org/packages/a9/d1/5bd907242f15fdeacaebcaad3bfb82b9c30cb1d71d3009fcfdb086948792/blis-0.7.7.tar.gz"
    sha256 "5d4a81f9438db7a19ac8e64ad41331f65a659ea8f3bb1889a9c2088cfd9fe104"
  end
  # resource cachetools==5.0.0
  resource "cachetools" do
    url "https://files.pythonhosted.org/packages/ad/81/539036a8716b4e0a96f77540194bb1e863a24b8e9bc9ddd74e30f1653df5/cachetools-5.0.0.tar.gz"
    sha256 "486471dfa8799eb7ec503a8059e263db000cdda20075ce5e48903087f79d5fd6"
  end
  # resource catalogue==2.0.7
  resource "catalogue" do
    url "https://files.pythonhosted.org/packages/e3/9b/ec6b4eecf62023a37683e97904683f0f2e40e8bdb73c197205cbc302f50c/catalogue-2.0.7.tar.gz"
    sha256 "535d33ae79ebd21ca298551d85da186ae8b8e1df36b0fb0246da774163ec2d6b"
  end
  # resource certifi==2021.10.8
  resource "certifi" do
    url "https://files.pythonhosted.org/packages/6c/ae/d26450834f0acc9e3d1f74508da6df1551ceab6c2ce0766a593362d6d57f/certifi-2021.10.8.tar.gz"
    sha256 "78884e7c1d4b00ce3cea67b44566851c4343c120abd683433ce934a68ea58872"
  end
  # resource cffi==1.15.0
  resource "cffi" do
    url "https://files.pythonhosted.org/packages/00/9e/92de7e1217ccc3d5f352ba21e52398372525765b2e0c4530e6eb2ba9282a/cffi-1.15.0.tar.gz"
    sha256 "920f0d66a896c2d99f0adbb391f990a84091179542c205fa53ce5787aff87954"
  end
  # resource chardet==4.0.0
  resource "chardet" do
    url "https://files.pythonhosted.org/packages/ee/2d/9cdc2b527e127b4c9db64b86647d567985940ac3698eeabc7ffaccb4ea61/chardet-4.0.0.tar.gz"
    sha256 "0d6f53a15db4120f2b08c94f11e7d93d2c911ee118b6b30a04ec3ee8310179fa"
  end
  # resource charset-normalizer==2.0.12
  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/56/31/7bcaf657fafb3c6db8c787a865434290b726653c912085fbd371e9b92e1c/charset-normalizer-2.0.12.tar.gz"
    sha256 "2857e29ff0d34db842cd7ca3230549d1a697f96ee6d3fb071cfa6c7393832597"
  end
  # resource click==8.0.4
  resource "click" do
    url "https://files.pythonhosted.org/packages/dd/cf/706c1ad49ab26abed0b77a2f867984c1341ed7387b8030a6aa914e2942a0/click-8.0.4.tar.gz"
    sha256 "8458d7b1287c5fb128c90e23381cf99dcde74beaf6c7ff6384ce84d6fe090adb"
  end
  # resource colorama==0.4.4
  resource "colorama" do
    url "https://files.pythonhosted.org/packages/1f/bb/5d3246097ab77fa083a61bd8d3d527b7ae063c7d8e8671b1cf8c4ec10cbe/colorama-0.4.4.tar.gz"
    sha256 "5941b2b48a20143d2267e95b1c2a7603ce057ee39fd88e7329b0c292aa16869b"
  end
  # resource cryptography==36.0.2
  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/10/a7/51953e73828deef2b58ba1604de9167843ee9cd4185d8aaffcb45dd1932d/cryptography-36.0.2.tar.gz"
    sha256 "70f8f4f7bb2ac9f340655cbac89d68c527af5bb4387522a8413e841e3e6628c9"
  end
  # resource cssselect==1.1.0
  resource "cssselect" do
    url "https://files.pythonhosted.org/packages/70/54/37630f6eb2c214cdee2ae56b7287394c8aa2f3bafb8b4eb8c3791aae7a14/cssselect-1.1.0.tar.gz"
    sha256 "f95f8dedd925fd8f54edb3d2dfb44c190d9d18512377d3c1e2388d16126879bc"
  end
  # resource cssutils==2.4.0
  resource "cssutils" do
    url "https://files.pythonhosted.org/packages/f4/ea/d09b04b5cf6ad84f45ca4c523d3e153dd9be1f12650c825d1c92ca0618a2/cssutils-2.4.0.tar.gz"
    sha256 "2d97210a83b0a3fe1e4469f5ff9a6420b078572035188b1bab7103c3a36dc89b"
  end
  # resource curlify==2.2.1
  resource "curlify" do
    url "https://files.pythonhosted.org/packages/fa/2c/9254b2294d0250291560d78e16e5cd764b8e2caa75d4cad1e8ae9d73899d/curlify-2.2.1.tar.gz"
    sha256 "0d3f02e7235faf952de8ef45ef469845196d30632d5838bcd5aee217726ddd6d"
  end
  # resource cymem==2.0.6
  resource "cymem" do
    url "https://files.pythonhosted.org/packages/5c/f8/16dccb3f9ac72bbaee8049b1d78df6e0623a1699c402687f2acdf15026af/cymem-2.0.6.tar.gz"
    sha256 "169725b5816959d34de2545b33fee6a8021a6e08818794a426c5a4f981f17e5e"
  end
  # resource decorator==5.1.1
  resource "decorator" do
    url "https://files.pythonhosted.org/packages/66/0c/8d907af351aa16b42caae42f9d6aa37b900c67308052d10fdce809f8d952/decorator-5.1.1.tar.gz"
    sha256 "637996211036b6385ef91435e4fae22989472f9d571faba8927ba8253acbc330"
  end
  # resource defusedxml==0.7.1
  resource "defusedxml" do
    url "https://files.pythonhosted.org/packages/0f/d5/c66da9b79e5bdb124974bfe172b4daf3c984ebd9c2a06e2b8a4dc7331c72/defusedxml-0.7.1.tar.gz"
    sha256 "1bb3032db185915b62d7c6209c5a8792be6a32ab2fedacc84e01b52c51aa3e69"
  end
  # resource dnspython==2.2.1
  resource "dnspython" do
    url "https://files.pythonhosted.org/packages/99/fb/e7cd35bba24295ad41abfdff30f6b4c271fd6ac70d20132fa503c3e768e0/dnspython-2.2.1.tar.gz"
    sha256 "0f7569a4a6ff151958b64304071d370daa3243d15941a7beedf0c9fe5105603e"
  end
  # resource ecdsa==0.17.0
  resource "ecdsa" do
    url "https://files.pythonhosted.org/packages/bf/3d/3d909532ad541651390bf1321e097404cbd39d1d89c2046f42a460220fb3/ecdsa-0.17.0.tar.gz"
    sha256 "b9f500bb439e4153d0330610f5d26baaf18d17b8ced1bc54410d189385ea68aa"
  end
  # resource email-validator==1.2.0
  resource "email-validator" do
    url "https://files.pythonhosted.org/packages/59/88/3e0cf4f13623e969015fe2b911633b889ca9bc6df5489a1bdfbb279a6cb0/email_validator-1.2.0.tar.gz"
    sha256 "565fd3a7aa4516772f55732d50d34d0a18680b5f62995aea8b4a55b62c90c517"
  end
  # resource emails==0.6
  resource "emails" do
    url "https://files.pythonhosted.org/packages/d3/f9/c1e315aa82ed9f037186c30109200fb4b4c51b5483b8065daa0ca836a336/emails-0.6.tar.gz"
    sha256 "a4c2d67ea8b8831967a750d8edc6e77040d7693143fe280e6d2a367d9c36ff88"
  end
  # resource fastapi==0.75.2
  resource "fastapi" do
    url "https://files.pythonhosted.org/packages/2c/1c/195178dfef05e6688d9201aca157b5b8a23171dfc685450fba138547d465/fastapi-0.75.2.tar.gz"
    sha256 "b5dac161ee19d33346040d3f44d8b7a9ac09b37df9efff95891f5e7641fa482f"
  end
  # resource frozenlist==1.3.0
  resource "frozenlist" do
    url "https://files.pythonhosted.org/packages/f4/f7/8dfeb76d2a52bcea2b0718427af954ffec98be1d34cd8f282034b3e36829/frozenlist-1.3.0.tar.gz"
    sha256 "ce6f2ba0edb7b0c1d8976565298ad2deba6f8064d2bebb6ffce2ca896eb35b0b"
  end
  # resource google-api-core==2.7.2
  resource "google-api-core" do
    url "https://files.pythonhosted.org/packages/08/ee/912307cf911fbc6faeefe80d1743f6b2bcf8e1e886dc707edc4d88e4461a/google-api-core-2.7.2.tar.gz"
    sha256 "65480309a7437f739e4476da037af02a3ec8263f1d1f89f72bbdc8f54fe402d2"
  end
  # resource google-api-python-client==2.46.0
  resource "google-api-python-client" do
    url "https://files.pythonhosted.org/packages/57/2e/cbed6b49ff1df5e4a332e03734eaa47d300a94d9975cf97485ba4785117b/google-api-python-client-2.46.0.tar.gz"
    sha256 "ba41ce1da337d39d76da1c5affea6e0b95bb6da74aa2adfe5a40618dd67a01fe"
  end
  # resource google-auth==2.6.5
  resource "google-auth" do
    url "https://files.pythonhosted.org/packages/b8/3f/31909cc7712ba4c0886e806383a1b72a4b43caee4951226b466a6b946c82/google-auth-2.6.5.tar.gz"
    sha256 "04e224f241c0566477bb35a8a93be8c635210de743bde454d49393cfb605266d"
  end
  # resource google-auth-httplib2==0.1.0
  resource "google-auth-httplib2" do
    url "https://files.pythonhosted.org/packages/c6/b5/a9e956fd904ecb34ec9d297616fe98fa4106fc12f3b0a914dec983c267b9/google-auth-httplib2-0.1.0.tar.gz"
    sha256 "a07c39fd632becacd3f07718dfd6021bf396978f03ad3ce4321d060015cc30ac"
  end
  # resource google-auth-oauthlib==0.5.1
  resource "google-auth-oauthlib" do
    url "https://files.pythonhosted.org/packages/14/49/9f23d33e5872446c8162d63f035f222c1d0d74d0fbe00cea9e2538351432/google-auth-oauthlib-0.5.1.tar.gz"
    sha256 "30596b824fc6808fdaca2f048e4998cc40fb4b3599eaea66d28dc7085b36c5b8"
  end
  # resource googleapis-common-protos==1.56.0
  resource "googleapis-common-protos" do
    url "https://files.pythonhosted.org/packages/dc/11/52169cc0f9a94ab6eb0873ae441bd8c58e5a757240faef973e04b6503816/googleapis-common-protos-1.56.0.tar.gz"
    sha256 "4007500795bcfc269d279f0f7d253ae18d6dc1ff5d5a73613ffe452038b1ec5f"
  end
  # resource graphql-core==3.2.1
  resource "graphql-core" do
    url "https://files.pythonhosted.org/packages/61/9e/798c1cfc5b03e98f068a793c2d2f1fd94f76ba50521f3812ff1a4e3c29d2/graphql-core-3.2.1.tar.gz"
    sha256 "9d1bf141427b7d54be944587c8349df791ce60ade2e3cccaf9c56368c133c201"
  end
  # resource h11==0.12.0
  resource "h11" do
    url "https://files.pythonhosted.org/packages/bd/e9/72c3dc8f7dd7874812be6a6ec788ba1300bfe31570963a7e788c86280cb9/h11-0.12.0.tar.gz"
    sha256 "47222cb6067e4a307d535814917cd98fd0a57b6788ce715755fa2b6c28b56042"
  end
  # resource httpcore==0.14.7
  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/f2/46/2c1e32574749d38404c9380d5c0de3f6fba44ceea119cf1536f138e72784/httpcore-0.14.7.tar.gz"
    sha256 "7503ec1c0f559066e7e39bc4003fd2ce023d01cf51793e3c173b864eb456ead1"
  end
  # resource httplib2==0.20.4
  resource "httplib2" do
    url "https://files.pythonhosted.org/packages/9c/65/57ad964eb8d45cc3d1316ce5ada2632f74e35863a0e57a52398416a182a1/httplib2-0.20.4.tar.gz"
    sha256 "58a98e45b4b1a48273073f905d2961666ecf0fbac4250ea5b47aef259eb5c585"
  end
  # resource httpx==0.22.0
  resource "httpx" do
    url "https://files.pythonhosted.org/packages/59/07/de30dd4bb26131bf34fe82bf721a392ff21e35bb2707ef8cbec954054a23/httpx-0.22.0.tar.gz"
    sha256 "d8e778f76d9bbd46af49e7f062467e3157a5a3d2ae4876a4bbfd8a51ed9c9cb4"
  end
  # resource hypothesis==6.43.1
  resource "hypothesis" do
    url "https://files.pythonhosted.org/packages/f3/7c/48949bfe5e7d1c944ee3d1d9ebf5b5e7412fc4792192f6bb1f32d3c26cb7/hypothesis-6.43.1.tar.gz"
    sha256 "b0ef5f82bb925e540f5d26e7e06280fa88113a763cc3e6832c93301766fa6900"
  end
  # resource hypothesis-graphql==0.5.1
  resource "hypothesis-graphql" do
    url "https://files.pythonhosted.org/packages/15/56/f239812687a7dd1d6bdaabef162ee30d5c793f5b8d07e5368ec37bc73300/hypothesis-graphql-0.5.1.tar.gz"
    sha256 "ba878305dae2f6df99d2fb390f49028695976a28114e4860c1a7d8e37f417222"
  end
  # resource hypothesis-jsonschema==0.22.0
  resource "hypothesis-jsonschema" do
    url "https://files.pythonhosted.org/packages/81/e0/c2802558d47e179e234f45c5d9dc39ff45d30d28692839a10be391d892fd/hypothesis-jsonschema-0.22.0.tar.gz"
    sha256 "359504080a422924a77263789a00c4995b061991558ff6a8243949f94a4d74fc"
  end
  # resource idna==3.3
  resource "idna" do
    url "https://files.pythonhosted.org/packages/62/08/e3fc7c8161090f742f504f40b1bccbfc544d4a4e09eb774bf40aafce5436/idna-3.3.tar.gz"
    sha256 "9d643ff0a55b762d5cdb124b8eaa99c66322e2157b69160bc32796e824360e6d"
  end
  # resource iniconfig==1.1.1
  resource "iniconfig" do
    url "https://files.pythonhosted.org/packages/23/a2/97899f6bd0e873fed3a7e67ae8d3a08b21799430fb4da15cfedf10d6e2c2/iniconfig-1.1.1.tar.gz"
    sha256 "bc3af051d7d14b2ee5ef9969666def0cd1a000e121eaea580d4a313df4b37f32"
  end
  # resource jinja2==3.1.1
  # resource jira==2.0.0
  resource "jira" do
    url "https://files.pythonhosted.org/packages/98/25/22de2a31d679e23b0865d6c39c6fd8e28da0bcfea3a1da1eeee0e4fdd286/jira-2.0.0.tar.gz"
    sha256 "e2a94adff98e45b29ded030adc76103eab34fa7d4d57303f211f572bedba0e93"
  end
  # resource joblib==1.1.0
  resource "joblib" do
    url "https://files.pythonhosted.org/packages/92/b9/9e3616e7e00c8165fb25175c53444533bdde05f3e974d45d9fcbbe451ee6/joblib-1.1.0.tar.gz"
    sha256 "4158fcecd13733f8be669be0683b96ebdbbd38d23559f54dca7205aea1bf1e35"
  end
  # resource jsonschema==4.4.0
  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/26/67/36cfd516f7b3560bbf7183d7a0f82bb9514d2a5f4e1d682a8a1d55d8031d/jsonschema-4.4.0.tar.gz"
    sha256 "636694eb41b3535ed608fe04129f26542b59ed99808b4f688aa32dcf55317a83"
  end
  # resource junit-xml==1.9
  # only doing this because junit-xml source is not available in PyPI for v1.9
  resource "junit-xml" do
    url "https://github.com/kyrus/python-junit-xml.git",
        revision: "4bd08a272f059998cedf9b7779f944d49eba13a6"
  end
  # resource langcodes==3.3.0
  resource "langcodes" do
    url "https://files.pythonhosted.org/packages/5f/ec/9955d772ecac0bdfb5d706d64f185ac68bd0d4092acdc2c5a1882c824369/langcodes-3.3.0.tar.gz"
    sha256 "794d07d5a28781231ac335a1561b8442f8648ca07cd518310aeb45d6f0807ef6"
  end
  # resource lxml==4.8.0
  resource "lxml" do
    url "https://files.pythonhosted.org/packages/3b/94/e2b1b3bad91d15526c7e38918795883cee18b93f6785ea8ecf13f8ffa01e/lxml-4.8.0.tar.gz"
    sha256 "f63f62fc60e6228a4ca9abae28228f35e1bd3ce675013d1dfb828688d50c6e23"
  end
  # resource mako==1.2.0
  resource "Mako" do
    url "https://files.pythonhosted.org/packages/50/ec/1d687348f0954bda388bfd1330c158ba8d7dea4044fc160e74e080babdb9/Mako-1.2.0.tar.gz"
    sha256 "9a7c7e922b87db3686210cf49d5d767033a41d4010b284e747682c92bddd8b39"
  end
  # resource markupsafe==2.1.1
  resource "MarkupSafe" do
    url "https://files.pythonhosted.org/packages/1d/97/2288fe498044284f39ab8950703e88abbac2abbdf65524d576157af70556/MarkupSafe-2.1.1.tar.gz"
    sha256 "7f91197cc9e48f989d12e4e6fbc46495c446636dfc81b9ccf50bb0ec74b91d4b"
  end
  # resource multidict==6.0.2
  resource "multidict" do
    url "https://files.pythonhosted.org/packages/fa/a7/71c253cdb8a1528802bac7503bf82fe674367e4055b09c28846fdfa4ab90/multidict-6.0.2.tar.gz"
    sha256 "5ff3bd75f38e4c43f1f470f2df7a4d430b821c4ce22be384e1459cb57d6bb013"
  end
  # resource murmurhash==1.0.6
  resource "murmurhash" do
    url "https://files.pythonhosted.org/packages/5e/d8/ef0ebb509ed1fabbd186e3b781fc6432b8fbddd42d20932ab6654c98a409/murmurhash-1.0.6.tar.gz"
    sha256 "00a5252b569d3f914b5bd0bce72d2efe9c0fb91a9703556ea1b608b141c68f2d"
  end
  # resource numpy==1.22.3
  resource "numpy" do
    url "https://files.pythonhosted.org/packages/64/4a/b008d1f8a7b9f5206ecf70a53f84e654707e7616a771d84c05151a4713e9/numpy-1.22.3.zip"
    sha256 "dbc7601a3b7472d559dc7b933b18b4b66f9aa7452c120e87dfb33d02008c8a18"
  end
  # resource oauth2client==4.1.3
  resource "oauth2client" do
    url "https://files.pythonhosted.org/packages/a6/7b/17244b1083e8e604bf154cf9b716aecd6388acd656dd01893d0d244c94d9/oauth2client-4.1.3.tar.gz"
    sha256 "d486741e451287f69568a4d26d70d9acd73a2bbfa275746c535b4209891cccc6"
  end
  # resource oauthlib[signedtoken]==3.2.0
  resource "oauthlib" do
    url "https://files.pythonhosted.org/packages/6e/7e/a43cec8b2df28b6494a865324f0ac4be213cb2edcf1e2a717547a93279b0/oauthlib-3.2.0.tar.gz"
    sha256 "23a8208d75b902797ea29fd31fa80a15ed9dc2c6c16fe73f5d346f83f6fa27a2"
  end
  # resource packaging==21.3
  resource "packaging" do
    url "https://files.pythonhosted.org/packages/df/9e/d1a7217f69310c1db8fdf8ab396229f55a699ce34a203691794c5d1cad0c/packaging-21.3.tar.gz"
    sha256 "dd47c42927d89ab911e606518907cc2d3a1f38bbd026385970643f9c5b8ecfeb"
  end
  # resource pandas==1.4.2
  resource "pandas" do
    url "https://files.pythonhosted.org/packages/5a/ac/b3b9aa2318de52e40c26ae7b9ce6d4e9d1bcdaf5da0899a691642117cf60/pandas-1.4.2.tar.gz"
    sha256 "92bc1fc585f1463ca827b45535957815b7deb218c549b7c18402c322c7549a12"
  end
  # resource pathy==0.6.1
  resource "pathy" do
    url "https://files.pythonhosted.org/packages/e8/8f/137abe1a49514991c49e2fa67127b9a739f34c3cfbf0ff4bf9953bf25df5/pathy-0.6.1.tar.gz"
    sha256 "838624441f799a06b446a657e4ecc9ebc3fdd05234397e044a7c87e8f6e76b1c"
  end
  # resource patsy==0.5.2
  resource "patsy" do
    url "https://files.pythonhosted.org/packages/af/dd/2041fbf661e823599f868c064804e20895b8a98ff428f97bea472734eb5e/patsy-0.5.2.tar.gz"
    sha256 "5053de7804676aba62783dbb0f23a2b3d74e35e5bfa238b88b7cbf148a38b69d"
  end
  # resource pbr==5.8.1
  resource "pbr" do
    url "https://files.pythonhosted.org/packages/51/da/eb358ed53257a864bf9deafba25bc3d6b8d41b0db46da4e7317500b1c9a5/pbr-5.8.1.tar.gz"
    sha256 "66bc5a34912f408bb3925bf21231cb6f59206267b7f63f3503ef865c1a292e25"
  end
  # resource pdpyras==4.5.0
  resource "pdpyras" do
    url "https://files.pythonhosted.org/packages/77/2b/47d2ca9e169b797228c72917f3b56430c2f2f16a8b4dd3c6ec891786a48c/pdpyras-4.5.0.tar.gz"
    sha256 "0d09ab50ddd220c1b77f692ab68e1b4324c97811cdefd9c6e84665d5417e716e"
  end
  # resource pluggy==1.0.0
  resource "pluggy" do
    url "https://files.pythonhosted.org/packages/a1/16/db2d7de3474b6e37cbb9c008965ee63835bba517e22cdb8c35b5116b5ce1/pluggy-1.0.0.tar.gz"
    sha256 "4224373bacce55f955a878bf9cfa763c1e360858e330072059e10bad68531159"
  end
  # resource premailer==3.10.0
  resource "premailer" do
    url "https://files.pythonhosted.org/packages/a3/6f/e49bd31941eff2987076383fa6d811eb785a28f498f5bb131e981bd71e13/premailer-3.10.0.tar.gz"
    sha256 "d1875a8411f5dc92b53ef9f193db6c0f879dc378d618e0ad292723e388bfe4c2"
  end
  # resource preshed==3.0.6
  resource "preshed" do
    url "https://files.pythonhosted.org/packages/c7/2e/f8ad19fa853727dfeee1114ee4ff45f10f259cbddf5cd23289992c06ccf4/preshed-3.0.6.tar.gz"
    sha256 "fb3b7588a3a0f2f2f1bf3fe403361b2b031212b73a37025aea1df7215af3772a"
  end
  # resource protobuf==3.20.0
  resource "protobuf" do
    url "https://files.pythonhosted.org/packages/6d/3e/40c56d21154a1f3ababb69f675333d7fb70c8293f9ca42ea3e448327fc50/protobuf-3.20.0.tar.gz"
    sha256 "71b2c3d1cd26ed1ec7c8196834143258b2ad7f444efff26fdc366c6f5e752702"
  end
  # resource psycopg2-binary==2.9.3
  resource "psycopg2-binary" do
    url "https://files.pythonhosted.org/packages/d7/1c/8d042630c5ff3c3e6d93c992bd7ecf516d577803b96781c6caa649bbf6e5/psycopg2-binary-2.9.3.tar.gz"
    sha256 "761df5313dc15da1502b21453642d7599d26be88bff659382f8f9747c7ebea4e"
  end
  # resource py==1.11.0
  resource "py" do
    url "https://files.pythonhosted.org/packages/98/ff/fec109ceb715d2a6b4c4a85a61af3b40c723a961e8828319fbcb15b868dc/py-1.11.0.tar.gz"
    sha256 "51c75c4126074b472f746a24399ad32f6053d1b34b68d2fa41e558e6f4a98719"
  end
  # resource pyasn1==0.4.8
  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/a4/db/fffec68299e6d7bad3d504147f9094830b704527a7fc098b721d38cc7fa7/pyasn1-0.4.8.tar.gz"
    sha256 "aef77c9fb94a3ac588e87841208bdec464471d9871bd5050a287cc9a475cd0ba"
  end
  # resource pyasn1-modules==0.2.8
  resource "pyasn1-modules" do
    url "https://files.pythonhosted.org/packages/88/87/72eb9ccf8a58021c542de2588a867dbefc7556e14b2866d1e40e9e2b587e/pyasn1-modules-0.2.8.tar.gz"
    sha256 "905f84c712230b2c592c19470d3ca8d552de726050d1d1716282a1f6146be65e"
  end
  # resource pycparser==2.21
  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/5e/0b/95d387f5f4433cb0f53ff7ad859bd2c6051051cebbb564f139a999ab46de/pycparser-2.21.tar.gz"
    sha256 "e644fdec12f7872f86c58ff790da456218b10f863970249516d60a5eaca77206"
  end
  # resource pydantic==1.8.2
  resource "pydantic" do
    url "https://files.pythonhosted.org/packages/b9/d2/12a808613937a6b98cd50d6467352f01322dc0d8ca9fb5b94441625d6684/pydantic-1.8.2.tar.gz"
    sha256 "26464e57ccaafe72b7ad156fdaa4e9b9ef051f69e175dbbb463283000c05ab7b"
  end
  # resource pyjwt==2.3.0
  resource "pyjwt" do
    url "https://files.pythonhosted.org/packages/1d/8e/01bdcfdbb352daaba8ea406d9df149c5bba7dbf70f908d4fa4c269fe6a08/PyJWT-2.3.0.tar.gz"
    sha256 "b888b4d56f06f6dcd777210c334e69c737be74755d3e5e9ee3fe67dc18a0ee41"
  end
  # resource pyparsing==3.0.8
  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/31/df/789bd0556e65cf931a5b87b603fcf02f79ff04d5379f3063588faaf9c1e4/pyparsing-3.0.8.tar.gz"
    sha256 "7bf433498c016c4314268d95df76c81b842a4cb2b276fa3312cfb1e1d85f6954"
  end
  # resource pyrsistent==0.18.1
  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/42/ac/455fdc7294acc4d4154b904e80d964cc9aae75b087bbf486be04df9f2abd/pyrsistent-0.18.1.tar.gz"
    sha256 "d4d61f8b993a7255ba714df3aca52700f8125289f84f704cf80916517c46eb96"
  end
  # resource pytest==7.1.2
  resource "pytest" do
    url "https://files.pythonhosted.org/packages/4e/1f/34657c6ac56f3c58df650ba41f8ffb2620281ead8e11bcdc7db63cf72a78/pytest-7.1.2.tar.gz"
    sha256 "a06a0425453864a270bc45e71f783330a7428defb4230fb5e6a731fde06ecd45"
  end
  # resource pytest-subtests==0.7.0
  resource "pytest-subtests" do
    url "https://files.pythonhosted.org/packages/b9/ea/3971817de038f8a03e8a1d1833ce5708965c67bacf1455d140f836c6f7f4/pytest-subtests-0.7.0.tar.gz"
    sha256 "95c44c77e3fbede9848bb88ca90b384815fcba8090ef9a9f55659ab163b1681c"
  end
  # resource python-dateutil==2.8.2
  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/4c/c4/13b4776ea2d76c115c1d1b84579f3764ee6d57204f6be27119f13a61d0a9/python-dateutil-2.8.2.tar.gz"
    sha256 "0123cacc1627ae19ddf3c27a5de5bd67ee4586fbdd6440d9748f8abb483d3e86"
  end
  # resource python-jose==3.3.0
  resource "python-jose" do
    url "https://files.pythonhosted.org/packages/e4/19/b2c86504116dc5f0635d29f802da858404d77d930a25633d2e86a64a35b3/python-jose-3.3.0.tar.gz"
    sha256 "55779b5e6ad599c6336191246e95eb2293a9ddebd555f796a65f838f07e5d78a"
  end
  # resource python-multipart==0.0.5
  resource "python-multipart" do
    url "https://files.pythonhosted.org/packages/46/40/a933ac570bf7aad12a298fc53458115cc74053474a72fbb8201d7dc06d3d/python-multipart-0.0.5.tar.gz"
    sha256 "f7bb5f611fc600d15fa47b3974c8aa16e93724513b49b5f95c81e6624c83fa43"
  end
  # resource python-slugify==6.1.2
  resource "python-slugify" do
    url "https://files.pythonhosted.org/packages/5d/45/915967d7bcc28fd12f36f554e1a64aeca36214f2be9caf87158168b5a575/python-slugify-6.1.2.tar.gz"
    sha256 "272d106cb31ab99b3496ba085e3fea0e9e76dcde967b5e9992500d1f785ce4e1"
  end
  # resource pytz==2022.1
  resource "pytz" do
    url "https://files.pythonhosted.org/packages/2f/5f/a0f653311adff905bbcaa6d3dfaf97edcf4d26138393c6ccd37a484851fb/pytz-2022.1.tar.gz"
    sha256 "1e760e2fe6a8163bc0b3d9a19c4f84342afa0a2affebfaa84b01b978a02ecaa7"
  end
  # resource pyyaml==6.0
  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/36/2b/61d51a2c4f25ef062ae3f74576b01638bebad5e045f747ff12643df63844/PyYAML-6.0.tar.gz"
    sha256 "68fb519c14306fec9720a2a5b45bc9f0c8d1b9c72adf45c37baedfcd949c35a2"
  end
  # resource requests==2.27.1
  resource "requests" do
    url "https://files.pythonhosted.org/packages/60/f3/26ff3767f099b73e0efa138a9998da67890793bfa475d8278f84a30fec77/requests-2.27.1.tar.gz"
    sha256 "68d7c56fd5a8999887728ef304a6d12edc7be74f1cfa47714fc8b414525c9a61"
  end
  # resource requests-oauthlib==1.3.1
  resource "requests-oauthlib" do
    url "https://files.pythonhosted.org/packages/95/52/531ef197b426646f26b53815a7d2a67cb7a331ef098bb276db26a68ac49f/requests-oauthlib-1.3.1.tar.gz"
    sha256 "75beac4a47881eeb94d5ea5d6ad31ef88856affe2332b9aafb52c6452ccf0d7a"
  end
  # resource requests-toolbelt==0.9.1
  resource "requests-toolbelt" do
    url "https://files.pythonhosted.org/packages/28/30/7bf7e5071081f761766d46820e52f4b16c8a08fef02d2eb4682ca7534310/requests-toolbelt-0.9.1.tar.gz"
    sha256 "968089d4584ad4ad7c171454f0a5c6dac23971e9472521ea3b6d49d610aa6fc0"
  end
  # resource rfc3986[idna2008]==1.5.0
  resource "rfc3986" do
    url "https://files.pythonhosted.org/packages/79/30/5b1b6c28c105629cc12b33bdcbb0b11b5bb1880c6cfbd955f9e792921aa8/rfc3986-1.5.0.tar.gz"
    sha256 "270aaf10d87d0d4e095063c65bf3ddbc6ee3d0b226328ce21e036f946e421835"
  end
  # resource rsa==4.8
  resource "rsa" do
    url "https://files.pythonhosted.org/packages/8c/ee/4022542e0fed77dd6ddade38e1e4dea3299f873b7fd4e6d78319953b0f83/rsa-4.8.tar.gz"
    sha256 "5c6bd9dc7a543b7fe4304a631f8a8a3b674e2bbfc49c2ae96200cdbe55df6b17"
  end
  # resource schedule==1.1.0
  resource "schedule" do
    url "https://files.pythonhosted.org/packages/a8/b5/a291a4c0faa491fd5baefa6d89011ece581cff47b23c0a39b42a63383358/schedule-1.1.0.tar.gz"
    sha256 "e6ca13585e62c810e13a08682e0a6a8ad245372e376ba2b8679294f377dfc8e4"
  end
  # resource schemathesis==3.14.2
  resource "schemathesis" do
    url "https://files.pythonhosted.org/packages/a3/c5/f1963e3e4b5ec56ee26bf9fe1b544701fd9fa3e7e8136fe3ee607662f868/schemathesis-3.14.2.tar.gz"
    sha256 "324aae9a44beadf8eac35996920c7483d5860b41ce9957decb1f9f2b83198323"
  end
  # resource scipy==1.8.0
  resource "scipy" do
    url "https://files.pythonhosted.org/packages/b4/a2/4faa34bf0cdbefd5c706625f1234987795f368eb4e97bde9d6f46860843e/scipy-1.8.0.tar.gz"
    sha256 "31d4f2d6b724bc9a98e527b5849b8a7e589bf1ea630c33aa563eda912c9ff0bd"
  end
  # resource sentry-asgi==0.2.0
  resource "sentry-asgi" do
    url "https://files.pythonhosted.org/packages/2b/94/7ea097693d638359ed91bb981438e6a0b4a26668660101a62683779ced4b/sentry-asgi-0.2.0.tar.gz"
    sha256 "0fc35fc6da9c16c0353f087c29fcfcd694b767bd1a77a2e768f519618eb3defd"
  end
  # resource sentry-sdk==1.5.10
  resource "sentry-sdk" do
    url "https://files.pythonhosted.org/packages/af/68/43d91ec36f09daf0cc0dd2dae9414f24f423ed56be6df2a9e5f317af26ee/sentry-sdk-1.5.10.tar.gz"
    sha256 "0a9eb20a84f4c17c08c57488d59fdad18669db71ebecb28fb0721423a33535f9"
  end
  # resource sh==1.14.2
  resource "sh" do
    url "https://files.pythonhosted.org/packages/80/39/ed280d183c322453e276a518605b2435f682342f2c3bcf63228404d36375/sh-1.14.2.tar.gz"
    sha256 "9d7bd0334d494b2a4609fe521b2107438cdb21c0e469ffeeb191489883d6fe0d"
  end
  # resource slack-sdk==3.15.2
  resource "slack-sdk" do
    url "https://files.pythonhosted.org/packages/a5/a6/14cbb27c34cbe7e0cdb741b234037934315aca215dff6f2fe9ba6592d144/slack_sdk-3.15.2.tar.gz"
    sha256 "128f3bb0b5b91454a3d5f140a61f3db370a0e1b50ffe0a8d9e9ebe0e894faed7"
  end
  # resource smart-open==5.2.1
  resource "smart-open" do
    url "https://files.pythonhosted.org/packages/53/9e/7a25cefbe4b51ea9bf883999c359dd761d32dcd2f764b70805278bb20bde/smart_open-5.2.1.tar.gz"
    sha256 "75abf758717a92a8f53aa96953f0c245c8cedf8e1e4184903db3659b419d4c17"
  end
  # resource sniffio==1.2.0
  resource "sniffio" do
    url "https://files.pythonhosted.org/packages/a6/ae/44ed7978bcb1f6337a3e2bef19c941de750d73243fc9389140d62853b686/sniffio-1.2.0.tar.gz"
    sha256 "c4666eecec1d3f50960c6bdf61ab7bc350648da6c126e3cf6898d8cd4ddcd3de"
  end
  # resource sortedcontainers==2.4.0
  resource "sortedcontainers" do
    url "https://files.pythonhosted.org/packages/e8/c4/ba2f8066cceb6f23394729afe52f3bf7adec04bf9ed2c820b39e19299111/sortedcontainers-2.4.0.tar.gz"
    sha256 "25caa5a06cc30b6b83d11423433f65d1f9d76c4c6a0c90e3379eaa43b9bfdb88"
  end
  # resource spacy==3.2.4
  resource "spacy" do
    url "https://files.pythonhosted.org/packages/fb/02/602a15b7828021090054f9aeebc5e55c9fa0ce17d7ee3766eb12f740baa3/spacy-3.2.4.tar.gz"
    sha256 "3e4c6f298d54044582daca1142b082ee38831bb3d7bb931d2ee601e8b8dce64f"
  end
  # resource spacy-legacy==3.0.9
  resource "spacy-legacy" do
    url "https://files.pythonhosted.org/packages/68/7c/2ed6aae54e6fe543a3452b11e75ccd3aa124df77f466ec7877e294e36e13/spacy-legacy-3.0.9.tar.gz"
    sha256 "4f7dcbc4e6c8e8cb4eadbb009f9c0a1a2a67442e0032c8d6776c9470c3759903"
  end
  # resource spacy-loggers==1.0.2
  resource "spacy-loggers" do
    url "https://files.pythonhosted.org/packages/b7/b9/3a5f2091f4c51edc95d5dba7fb9ede932696b778107865db368acaae96fd/spacy-loggers-1.0.2.tar.gz"
    sha256 "e75d44f4cf99e6763d7132ca7c8c420e0a92790222a08bc8eb9e24ea2c13536e"
  end
  # resource sqlalchemy==1.3.24
  resource "sqlalchemy" do
    url "https://files.pythonhosted.org/packages/c5/ab/81bef2f960abf3cdaf32fbf1994f0c6f5e6a5f1667b5713ed6ebf162b6a2/SQLAlchemy-1.3.24.tar.gz"
    sha256 "ebbb777cbf9312359b897bf81ba00dae0f5cb69fba2a18265dcc18a6f5ef7519"
  end
  # resource sqlalchemy-filters==0.12.0
  resource "sqlalchemy-filters" do
    url "https://files.pythonhosted.org/packages/5d/3a/1bf3135bb7b46281f6ce815d25e43401a34612f939b42a993ac22cf16575/sqlalchemy-filters-0.12.0.tar.gz"
    sha256 "fbbdd98c7dd1e122b4b8ec979514d39d5fc72d3835086f8c013705aa52b2e2a6"
  end
  # resource sqlalchemy-utils==0.38.2
  resource "sqlalchemy-utils" do
    url "https://files.pythonhosted.org/packages/64/a7/6d1c24e5f8cee222ee9de813081400e7789bf47b445ae903ce4ddb6b157c/SQLAlchemy-Utils-0.38.2.tar.gz"
    sha256 "9e01d6d3fb52d3926fcd4ea4a13f3540701b751aced0316bff78264402c2ceb4"
  end
  # resource srsly==2.4.3
  resource "srsly" do
    url "https://files.pythonhosted.org/packages/11/0a/3ba48157c25ac5cb80233c35332e04b185bc98048a7928e91f5c58f0c743/srsly-2.4.3.tar.gz"
    sha256 "dbe91f6dd4aea9e819493628356dc715bd9c606486297bb7ca5748e6e003841c"
  end
  # resource starlette==0.17.1
  resource "starlette" do
    url "https://files.pythonhosted.org/packages/11/d3/c346849b8201f0e0339e23850c8db1cebd477e44e8b5212f40e1acbb490c/starlette-0.17.1.tar.gz"
    sha256 "57eab3cc975a28af62f6faec94d355a410634940f10b30d68d31cb5ec1b44ae8"
  end
  # resource statsmodels==0.13.2
  resource "statsmodels" do
    url "https://files.pythonhosted.org/packages/e1/4a/0eb4efa49cc352e2721e2aebfe8573264db2add195545ec3979c98040c3b/statsmodels-0.13.2.tar.gz"
    sha256 "77dc292c9939c036a476f1770f9d08976b05437daa229928da73231147cde7d4"
  end
  # resource tabulate==0.8.9
  resource "tabulate" do
    url "https://files.pythonhosted.org/packages/ae/3d/9d7576d94007eaf3bb685acbaaec66ff4cdeb0b18f1bf1f17edbeebffb0a/tabulate-0.8.9.tar.gz"
    sha256 "eb1d13f25760052e8931f2ef80aaf6045a6cceb47514db8beab24cded16f13a7"
  end
  # resource tenacity==8.0.1
  resource "tenacity" do
    url "https://files.pythonhosted.org/packages/2c/f5/04748914f5c78f7418b803226bd56cdddd70ac369b936b3e24f5158017f1/tenacity-8.0.1.tar.gz"
    sha256 "43242a20e3e73291a28bcbcacfd6e000b02d3857a9a9fff56b297a27afdc932f"
  end
  # resource text-unidecode==1.3
  resource "text-unidecode" do
    url "https://files.pythonhosted.org/packages/ab/e2/e9a00f0ccb71718418230718b3d900e71a5d16e701a3dae079a21e9cd8f8/text-unidecode-1.3.tar.gz"
    sha256 "bad6603bb14d279193107714b288be206cac565dfa49aa5b105294dd5c4aab93"
  end
  # resource thinc==8.0.15
  resource "thinc" do
    url "https://files.pythonhosted.org/packages/bd/57/a637089b8681f7c9055333c7b7637b1072f53a600632414605486623b4de/thinc-8.0.15.tar.gz"
    sha256 "2e315020da85c3791e191fbf37c4a2433f57cf322e27380da0cd4de99d96053b"
  end
  # resource tomli==2.0.1
  resource "tomli" do
    url "https://files.pythonhosted.org/packages/c0/3f/d7af728f075fb08564c5949a9c95e44352e23dee646869fa104a3b2060a3/tomli-2.0.1.tar.gz"
    sha256 "de526c12914f0c550d15924c62d72abc48d6fe7364aa87328337a31007fe8a4f"
  end
  # resource tomli-w==1.0.0
  resource "tomli-w" do
    url "https://files.pythonhosted.org/packages/49/05/6bf21838623186b91aedbda06248ad18f03487dc56fbc20e4db384abde6c/tomli_w-1.0.0.tar.gz"
    sha256 "f463434305e0336248cac9c2dc8076b707d8a12d019dd349f5c1e382dd1ae1b9"
  end
  # resource tqdm==4.64.0
  resource "tqdm" do
    url "https://files.pythonhosted.org/packages/98/2a/838de32e09bd511cf69fe4ae13ffc748ac143449bfc24bb3fd172d53a84f/tqdm-4.64.0.tar.gz"
    sha256 "40be55d30e200777a307a7585aee69e4eabb46b4ec6a4b4a5f2d9f11e7d5408d"
  end
  # resource typer==0.4.1
  resource "typer" do
    url "https://files.pythonhosted.org/packages/84/f2/71a04c8aa8718570d6f7570f6871fd358c29c715035f63630dadbd460da8/typer-0.4.1.tar.gz"
    sha256 "5646aef0d936b2c761a10393f0384ee6b5c7fe0bb3e5cd710b17134ca1d99cff"
  end
  # resource typing-extensions==4.1.1
  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/b1/5a/8b5fbb891ef3f81fc923bf3cb4a578c0abf9471eb50ce0f51c74212182ab/typing_extensions-4.1.1.tar.gz"
    sha256 "1a9462dcc3347a79b1f1c0271fbe79e844580bb598bafa1ed208b94da3cdcd42"
  end
  # resource uritemplate==4.1.1
  resource "uritemplate" do
    url "https://files.pythonhosted.org/packages/d2/5a/4742fdba39cd02a56226815abfa72fe0aa81c33bed16ed045647d6000eba/uritemplate-4.1.1.tar.gz"
    sha256 "4346edfc5c3b79f694bccd6d6099a322bbeb628dbf2cd86eea55a456ce5124f0"
  end
  # resource urllib3==1.26.9
  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/1b/a5/4eab74853625505725cefdf168f48661b2cd04e7843ab836f3f63abf81da/urllib3-1.26.9.tar.gz"
    sha256 "aabaf16477806a5e1dd19aa41f8c2b7950dd3c746362d7e3223dbe6de6ac448e"
  end
  # resource uvicorn==0.17.6
  resource "uvicorn" do
    url "https://files.pythonhosted.org/packages/6d/7d/b97c120cad5fd1f66462afb0d5ddd043078f2380b89fccd8a97ef5c95b5c/uvicorn-0.17.6.tar.gz"
    sha256 "5180f9d059611747d841a4a4c4ab675edf54c8489e97f96d0583ee90ac3bfc23"
  end
  # resource validators==0.18.2
  resource "validators" do
    url "https://files.pythonhosted.org/packages/33/1a/4e4c12982b093796c1ceaff49cbc5998fb3a7866da755f8e7a1a40b8fda4/validators-0.18.2.tar.gz"
    sha256 "37cd9a9213278538ad09b5b9f9134266e7c226ab1fede1d500e29e0a8fbb9ea6"
  end
  # resource wasabi==0.9.1
  resource "wasabi" do
    url "https://files.pythonhosted.org/packages/25/fe/a2408e8af6fc88769fc78a8ef7146055b95ae3e7b9a116c5137d58df02a9/wasabi-0.9.1.tar.gz"
    sha256 "ada6f13e9b70ef26bf95fad0febdfdebe2005e29a08ad58f4bbae383a97298cf"
  end
  # resource werkzeug==2.1.1
  resource "werkzeug" do
    url "https://files.pythonhosted.org/packages/10/cf/97eb1a3847c01ae53e8376bc21145555ac95279523a935963dc8ff96c50b/Werkzeug-2.1.2.tar.gz"
    sha256 "1ce08e8093ed67d638d63879fd1ba3735817f7a80de3674d293f5984f25fb6e6"
  end
  # resource yarl==1.7.2
  resource "yarl" do
    url "https://files.pythonhosted.org/packages/f6/da/46d1b3d69a9a0835dabf9d59c7eb0f1600599edd421a4c5a15ab09f527e0/yarl-1.7.2.tar.gz"
    sha256 "45399b46d60c253327a460e99856752009fcee5f5d3c80b2f7c0cae1c38d56dd"
  end

  def install
    ENV.prepend_path "PATH", Formula["node"].libexec/"bin"
    virtualenv_install_with_resources
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test dispatch`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
