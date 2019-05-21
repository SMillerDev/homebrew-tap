class TestKitchen < Formula
  desc "Tool for developing and testing infrastructure code"
  homepage "https://kitchen.ci"
  url "https://github.com/test-kitchen/test-kitchen/archive/v2.2.5.tar.gz"
  sha256 "65144174f654a085726b9ec13c760dafc0ff363218143e55997d2ba3bfa72748"

  depends_on "ruby" if MacOS.version <= :sierra

  resource "mixlib-shellout" do
    url "https://rubygems.org/gems/mixlib-shellout-2.4.4.gem"
    sha256 "823f80dce9e9d5aeab04df486077e08929324b05aef17c773da09c1cbe1e18ba"
  end

  resource "mixlib-install" do
    url "https://rubygems.org/gems/mixlib-install-3.11.12.gem"
    sha256 "731822b919e172ae2d2f98b1199189696279bd5c727145753a56774cb59b2a66"
  end

  resource "mixlib-versioning" do
    url "https://rubygems.org/gems/mixlib-versioning-1.2.7.gem"
    sha256 "86255a388fbc4bffb15cb7641e64aaea709d69b89352028e980a9b776ae0170f"
  end

  resource "mixlib-log" do
    url "https://rubygems.org/gems/mixlib-log-3.0.1.gem"
    sha256 "13bde5cc9edd18f2d3d11352e1c033c05c3790c97e3d16409c582f2588660ad8"
  end

  resource "builder" do
    url "https://rubygems.org/gems/builder-3.2.3.gem"
    sha256 "21f3026ba615d87488329aff4aa4c10464563de3c648f678d8edd26374892b62"
  end

  resource "erubis" do
    url "https://rubygems.org/gems/erubis-2.7.0.gem"
    sha256 "63653f5174a7997f6f1d6f465fbe1494dcc4bdab1fb8e635f6216989fb1148ba"
  end

  resource "gssapi" do
    url "https://rubygems.org/gems/gssapi-1.3.0.gem"
    sha256 "90c7ccdcb7d0742e062ee8ab17465ee97a9bd14dd81ac1d9d97bf4ec16be868e"
  end

  resource "ffi" do
    url "https://rubygems.org/gems/ffi-1.10.0.gem"
    sha256 "17001940b28a961c94251a39f0ae00b32c2d0850479b5978c971759591fc1749"
  end

  resource "gyoku" do
    url "https://rubygems.org/gems/gyoku-1.3.1.gem"
    sha256 "b0c5c825718df093437ab6bf84a25f39711816ab52a3bb3d2dcfa44102d5c0f2"
  end

  resource "httpclient" do
    url "https://rubygems.org/gems/httpclient-2.8.3.gem"
    sha256 "2951e4991214464c3e92107e46438527d23048e634f3aee91c719e0bdfaebda6"
  end

  resource "logging" do
    url "https://rubygems.org/gems/logging-2.2.2.gem"
    sha256 "963359dbdab725a3320eab179017d20d5b9731d7148e1efa8432c184a48a461a"
  end

  resource "little-plugger" do
    url "https://rubygems.org/gems/little-plugger-1.1.4.gem"
    sha256 "d5f347c00d9d648040ef7c17d6eb09d3d0719adf19ca30d1a3b6fb26d0a631bb"
  end

  resource "multi_json" do
    url "https://rubygems.org/gems/multi_json-1.13.1.gem"
    sha256 "db8613c039b9501e6b2fb85efe4feabb02f55c3365bae52bba35381b89c780e6"
  end

  resource "nori" do
    url "https://rubygems.org/gems/nori-2.6.0.gem"
    sha256 "f629a4e92fe394e78f9441d55e71f5606ce8c045f3cc81f326f70b45ce61dc18"
  end

  resource "rubyntlm" do
    url "https://rubygems.org/gems/rubyntlm-0.6.2.gem"
    sha256 "be81d7cbe7042c3a582299d89f0b07ef142b9854d260b648b498ad49a7eecbdc"
  end

  resource "rubyzip" do
    url "https://rubygems.org/gems/rubyzip-1.2.2.gem"
    sha256 "32fb890700caae31eec13bcc3b4a15aff74cc3fb1d1222fc113041deb45834d8"
  end

  resource "pastel" do
    url "https://rubygems.org/gems/pastel-0.7.2.gem"
    sha256 "e1d21dd8fb965e5052d1b16164a777fc450c6e187bf199f833a9de3f5303c3f9"
  end

  resource "equatable" do
    url "https://rubygems.org/gems/equatable-0.5.0.gem"
    sha256 "fdc8669f9bdc993be5cb6c08ec86343a7e87756e33c68ff5f63dfaa9e44f55ea"
  end

  resource "tty-color" do
    url "https://rubygems.org/gems/tty-color-0.4.3.gem"
    sha256 "731d0dd02da9c63aca126001153440df8971fee9163532064c46e6d58deae57f"
  end

  resource "tty-box" do
    url "https://rubygems.org/gems/tty-box-0.3.0.gem"
    sha256 "185de1bd80524e3e8a9cc1730ae107baec42d1a4f9f17cf9d1d234e96ace77e2"
  end

  resource "tty-cursor" do
    url "https://rubygems.org/gems/tty-cursor-0.6.1.gem"
    sha256 "03a39dba9fd7c915653e1c981cee3970f653f0f0fc68f05c081ffa26c3623559"
  end

  resource "tty-prompt" do
    url "https://rubygems.org/gems/tty-prompt-0.18.1.gem"
    sha256 "95c9bc8d70c6cb5aed5ae09914069e3db28b495c52787d4976c71e3f7fd654f2"
  end

  resource "tty-reader" do
    url "https://rubygems.org/gems/tty-reader-0.5.0.gem"
    sha256 "968f9a6e5667a37f9f6eff0dd9713faa7d61b14cc515b724aae2e63bab5b2c64"
  end

  resource "tty-screen" do
    url "https://rubygems.org/gems/tty-screen-0.6.5.gem"
    sha256 "816b3482054c5ff781b1232852c8f3a88bf5dac099a56ee9621ed506fd93f72b"
  end

  resource "tty-table" do
    url "https://rubygems.org/gems/tty-table-0.10.0.gem"
    sha256 "8f7dc9bfc3ffbea453bb9c302ad34adc8411b2ce5fab4bce5faeded283cc7916"
  end

  resource "wisper" do
    url "https://rubygems.org/gems/wisper-2.0.0.gem"
    sha256 "6d8623c76943612e8db81862af7eb20f5a8ad631fe1857d9f7ced97e87e5222b"
  end

  resource "timers" do
    url "https://rubygems.org/gems/timers-4.3.0.gem"
    sha256 "4c3fc3eba6f3bfcb6f3091587dcb09427746098c16916a8f1fd554c6a7de3098"
  end

  resource "necromancer" do
    url "https://rubygems.org/gems/necromancer-0.4.0.gem"
    sha256 "7fab7bc465a634365d354341a0f7a57a6928b7b06777442c3b377fb36783366d"
  end

  resource "strings" do
    url "https://rubygems.org/gems/strings-0.1.5.gem"
    sha256 "f12880759c16a6b7f048ebaa2577fdc74490e753f67d508610624628653e47b2"
  end

  resource "strings-ansi" do
    url "https://rubygems.org/gems/strings-ansi-0.1.0.gem"
    sha256 "3ef265ac7eb13eceeb9d1f475dff8d2f85f7ee6a0345b5de554a756523ffa6cb"
  end

  resource "unicode-display_width" do
    url "https://rubygems.org/gems/unicode-display_width-1.5.0.gem"
    sha256 "9890eebd24feb4cb0e0542c9b8c6beecb40cda27be8c7afe49312625b36156eb"
  end

  resource "unicode_utils" do
    url "https://rubygems.org/gems/unicode_utils-1.4.0.gem"
    sha256 "b922d0cf2313b6b7136ada6645ce7154ffc86418ca07d53b058efe9eb72f2a40"
  end

  resource "tomlrb" do
    url "https://rubygems.org/gems/tomlrb-1.2.8.gem"
    sha256 "3bdeb911ad88d5bdad73f685ff9e2aadc43dd44aa07858d9f0791baa9cd6483c"
  end

  resource "net-scp" do
    url "https://rubygems.org/gems/net-scp-1.2.1.gem"
    sha256 "928ca046246bdbfe304313c903bab95e7b711938ceff4a2c896b91ab59c6122c"
  end

  resource "net-ssh" do
    url "https://rubygems.org/gems/net-ssh-5.2.0.gem"
    sha256 "80a8a71d39e9f917ed265f66c0c5985f1849fc5e7156ac48f14dd1d4af683c80"
  end

  resource "net-ssh-gateway" do
    url "https://rubygems.org/gems/net-ssh-gateway-2.0.0.gem"
    sha256 "1d9cb51de52e2d64982f4c136c30435e914c05a980814a91055c89e183397bd0"
  end

  resource "ed25519" do
    url "https://rubygems.org/gems/ed25519-1.2.4.gem"
    sha256 "dc62c3491e9484d566519ab2bfca1406c7527694c902e6d05074c3a33ecab3b8"
  end

  resource "bcrypt_pbkdf" do
    url "https://rubygems.org/gems/bcrypt_pbkdf-1.0.1.gem"
    sha256 "65c4c8abd31109f47ec837fb3a6d052dc090d5fab5c943b2bef3d48244d67a0b"
  end

  resource "thor" do
    url "https://rubygems.org/gems/thor-0.20.3.gem"
    sha256 "49bc217fe28f6af34c6e60b003e3405c27595a55689077d82e9e61d4d3b519fa"
  end

  resource "winrm" do
    url "https://rubygems.org/gems/winrm-2.3.2.gem"
    sha256 "42ea116f9d8d8225979f743c7885b2cf68404e48626ffe94b08816d629cb7da7"
  end

  resource "winrm-elevated" do
    url "https://rubygems.org/gems/winrm-elevated-1.1.1.gem"
    sha256 "f3c7def4ddd2589678025003ee768bf68e0d6cc5f1b0d99cf1e500e8dc6058e9"
  end

  resource "winrm-fs" do
    url "https://rubygems.org/gems/winrm-fs-1.3.2.gem"
    sha256 "8381797a4ea1a2edafe4e19a71e2f6861b9f5715f460c860a959eb298af4c43b"
  end

  resource "license-acceptance" do
    url "https://rubygems.org/gems/license-acceptance-1.0.5.gem"
    sha256 "0cf19f634b3cfcf7a078889acb103cc74c768c531967e8695041f8652ced1548"
  end

  # Addditional resources
  resource "kitchen-salt" do
    url "https://rubygems.org/gems/kitchen-salt-0.6.0.gem"
    sha256 "fd069cb22105ce0de2aac2efebe15ee3e3715d60e7ec03341a67d65bdb251270"
  end

  resource "hashie" do
    url "https://rubygems.org/gems/hashie-3.6.0.gem"
    sha256 "b097778abd066b5b506a07a226037b45f2f1d45f13f7ef552813b122aefb6d8d"
  end

  resource "kitchen-inspec" do
    url "https://rubygems.org/gems/kitchen-inspec-1.1.0.gem"
    sha256 "fdd98b638dadc2fa2ce8ae33bbeb1de8c263722e1d2ca26de9ef1448446c33b6"
  end

  resource "inspec" do
    url "https://rubygems.org/gems/inspec-3.9.3.gem"
    sha256 "adc9f2c356b34705963856b07b4802749dd56499860388a3f30f6bde2eda2266"
  end

  resource "faraday_middleware" do
    url "https://rubygems.org/gems/faraday_middleware-0.12.2.gem"
    sha256 "2d90093c18c23e7f5a6f602ed3114d2c62abc3f7f959dd3046745b24a863f1dc"
  end

  resource "faraday" do
    url "https://rubygems.org/gems/faraday-0.15.4.gem"
    sha256 "00e6ffd6f1bccd9dc9e3b993a0004e69680559422206ce4cbb81fd2d0ba8e268"
  end

  resource "htmlentities" do
    url "https://rubygems.org/gems/htmlentities-4.3.4.gem"
    sha256 "125a73c6c9f2d1b62100b7c3c401e3624441b663762afa7fe428476435a673da"
  end

  resource "json" do
    url "https://rubygems.org/gems/json-2.2.0.gem"
    sha256 "9dd1437156773f72c096058ec837faac1b00077121a3fd574e68f895ea3aa96b"
  end

  resource "method_source" do
    url "https://rubygems.org/gems/method_source-0.9.2.gem"
    sha256 "980eba674be3d05dee1889d6cf1ce25735955a6394c6e38d7d2035dcf6e771df"
  end

  resource "multipart-post" do
    url "https://rubygems.org/gems/multipart-post-2.0.0.gem"
    sha256 "3dc44e50d3df3d42da2b86272c568fd7b75c928d8af3cc5f9834e2e5d9586026"
  end

  resource "parallel" do
    url "https://rubygems.org/gems/parallel-1.17.0.gem"
    sha256 "19554c18246eb75167baf5113ff4c32075d635bcfe3a08b80a75d296e5fb2ff4"
  end

  resource "parslet" do
    url "https://rubygems.org/gems/parslet-1.8.2.gem"
    sha256 "08d1ab3721cd3f175bfbee8788b2ddff71f92038f2d69bd65454c22bb9fbd98a"
  end

  resource "train" do
    url "https://rubygems.org/gems/train-1.7.6.gem"
    sha256 "11bd0e8c8a15d49db9ab6a9632bbf2794ad5b062c6c97381f9e9572c31850b74"
  end

  resource "train-habitat" do
    url "https://rubygems.org/gems/train-habitat-0.1.1.gem"
    sha256 "aa06b1fc498121155f9283ce8ae607ecd743d7dab0e2dbfecbd5773a5cdaeba8"
  end

  resource "docker-api" do
    url "https://rubygems.org/gems/docker-api-1.34.2.gem"
    sha256 "b7cd1db39428583dffb4e40c3875809dae8790d982466e9b008154d1cf5bb311"
  end

  resource "excon" do
    url "https://rubygems.org/gems/excon-0.64.0.gem"
    sha256 "f611f315563316c64fb3f1dcd78dc09fd279df565d4a53d8162fc7e9e9a6976d"
  end

  resource "aws-sdk" do
    url "https://rubygems.org/gems/aws-sdk-2.11.267.gem"
    sha256 "fc9c6efa027333fd985f939411725b8700f1d6f6133edfc82071427a588be458"
  end

  resource "aws-sdk-resources" do
    url "https://rubygems.org/gems/aws-sdk-resources-2.11.267.gem"
    sha256 "84a0cd11438dc57c335ac9b5ed29e9cdbd96c75cbe7cb7feeafddb23f38a7553"
  end

  resource "aws-sdk-core" do
    url "https://rubygems.org/gems/aws-sdk-core-2.11.267.gem"
    sha256 "335d367391f38c02a5ca432aeb1f81a7ec33607dfe16fec3e1458f6c5ddac47d"
  end

  resource "aws-sigv4" do
    url "https://rubygems.org/gems/aws-sigv4-1.1.0.gem"
    sha256 "9a09561befb5c93b32af6e0fefb85148cfcdd75db418b348dc94cbce4a44ccb5"
  end

  resource "aws-eventstream" do
    url "https://rubygems.org/gems/aws-eventstream-1.0.3.gem"
    sha256 "0663148610d2569af140fbb880880773b62b2c12ee1ccc7fb9e4f558d4390f80"
  end

  resource "jmespath" do
    url "https://rubygems.org/gems/jmespath-1.4.0.gem"
    sha256 "ee5930ed833d3472fce31abf2f4a39852718e90b099dc2a6713234d600539cb4"
  end

  resource "azure_graph_rbac" do
    url "https://rubygems.org/gems/azure_graph_rbac-0.17.1.gem"
    sha256 "f3616629904b21f1937269933591f73d8be37cae139ca76995346718b57d093b"
  end

  resource "ms_rest_azure" do
    url "https://rubygems.org/gems/ms_rest_azure-0.11.0.gem"
    sha256 "e33617017db51bb524b5febca6b2bd315682e11be0630aa8a2738181dc36389d"
  end

  resource "ms_rest" do
    url "https://rubygems.org/gems/ms_rest-0.7.3.gem"
    sha256 "9eeb48eed331e616747cf8bfc9982cddf82d018531fe5961bc6ec793066bc0f6"
  end

  resource "timeliness" do
    url "https://rubygems.org/gems/timeliness-0.4.0.gem"
    sha256 "2fa5808ed7dbeaaed0d2d7fa96dc4052bcbc6409a33a2336867d202dd42f8553"
  end

  resource "azure_mgmt_resources" do
    url "https://rubygems.org/gems/azure_mgmt_resources-0.17.4.gem"
    sha256 "b75a53ec747f6e29eb3fe8471570c500b086ae5493a13b125cb82187ae3250c3"
  end

  resource "azure_mgmt_key_vault" do
    url "https://rubygems.org/gems/azure_mgmt_key_vault-0.17.4.gem"
    sha256 "a597a65ea021ea6a28c7e4edd939e320cb7bef20b27f776557a584d013e75181"
  end

  resource "google-api-client" do
    url "https://rubygems.org/gems/google-api-client-0.23.9.gem"
    sha256 "4a1c10db8ab3f45d0bb6dae43c268aae1f5112c36abfd1a889ad2b8fd72c22fd"
  end

  resource "googleauth" do
    url "https://rubygems.org/gems/googleauth-0.6.7.gem"
    sha256 "98ba78eab60aef2f8517ba2008b2c02bed84785cafbde58bbdbd2a6f739047fa"
  end

  resource "signet" do
    url "https://rubygems.org/gems/signet-0.11.0.gem"
    sha256 "246a5768721946690804ae88f626d68f1ee070090d5729325884c955fe1aadb8"
  end

  resource "jwt" do
    url "https://rubygems.org/gems/jwt-2.1.0.gem"
    sha256 "7e7e7ffc1a5ebce628ac7da428341c50615a3a10ac47bb74c22c1cba325613f0"
  end

  resource "memoist" do
    url "https://rubygems.org/gems/memoist-0.16.0.gem"
    sha256 "70bd755b48477c9ef9601daa44d298e04a13c1727f8f9d38c34570043174085f"
  end

  resource "representable" do
    url "https://rubygems.org/gems/representable-3.0.4.gem"
    sha256 "07d43917dea4712ecebd19c1909e769deed863ad444d23ceb6461519e2cba962"
  end

  resource "declarative" do
    url "https://rubygems.org/gems/declarative-0.0.10.gem"
    sha256 "b26cfbd229fc54256132636a6073c67d3ca22a3f86bc15ee1cf1adfff9ee8218"
  end

  resource "declarative-option" do
    url "https://rubygems.org/gems/declarative-option-0.1.0.gem"
    sha256 "17508349f51c5631e5ad4158c29f78a4b2de618abffa066d76c11953705f91bc"
  end

  resource "retriable" do
    url "https://rubygems.org/gems/retriable-3.1.2.gem"
    sha256 "0a5a5d0ca4ba61a76fb31a17ab8f7f80281beb040c329d34dfc137a1398688e0"
  end

  resource "uber" do
    url "https://rubygems.org/gems/uber-0.1.0.gem"
    sha256 "5beeb407ff807b5db994f82fa9ee07cfceaa561dad8af20be880bc67eba935dc"
  end

  resource "os" do
    url "https://rubygems.org/gems/os-1.0.1.gem"
    sha256 "e3a8124676944a62f8706e6b3942786aad4ee585460bc7c9df548c17c02c251b"
  end

  resource "representable" do
    url "https://rubygems.org/gems/representable-3.0.4.gem"
    sha256 "07d43917dea4712ecebd19c1909e769deed863ad444d23ceb6461519e2cba962"
  end

  resource "mime-types" do
    url "https://rubygems.org/gems/mime-types-3.2.2.gem"
    sha256 "93f308f0b6754b0ca50dd1982b817f65b8946f6a34bd3db6bd3d8a5265f05d3a"
  end

  resource "mime-types-data" do
    url "https://rubygems.org/gems/mime-types-data-3.2019.0331.gem"
    sha256 "8a70976e9e3268e01df23bd8fdb503d80b285548f4754671b0875496c2bb00d4"
  end

  resource "concurrent-ruby" do
    url "https://rubygems.org/gems/concurrent-ruby-1.1.5.gem"
    sha256 "5611d14d8699996b17f18e704f4257b73349efa2d9a75fee6566a0a387c807f4"
  end

  resource "faraday-cookie_jar" do
    url "https://rubygems.org/gems/faraday-cookie_jar-0.0.6.gem"
    sha256 "66c7d899faa821bfb166dd93b5f928b184324b4dc7c89b67fb4619424c7f24b6"
  end

  resource "inifile" do
    url "https://rubygems.org/gems/inifile-3.0.0.gem"
    sha256 "b103eb3655ec93cc626cf2de00950e91f7e69b8398842968e17e1815cfacbfb0"
  end

  resource "http-cookie" do
    url "https://rubygems.org/gems/http-cookie-1.0.3.gem"
    sha256 "2f11269d817bc52ab2af2721e89a377660a961078de2a3a55fc696d7897e8c00"
  end

  resource "public_suffix" do
    url "https://rubygems.org/gems/public_suffix-3.0.3.gem"
    sha256 "d4f4addffbd1ad3e7b5bb2e258a761ccef5670c23c29b0476b2299bcca220623"
  end

  resource "domain_name" do
    url "https://rubygems.org/gems/domain_name-0.5.20180417.gem"
    sha256 "7b74d1fe58937c6021d210d123a8e880787a047dbc411cabd6475b6216a76d29"
  end

  resource "unf" do
    url "https://rubygems.org/gems/unf-0.1.4.gem"
    sha256 "4999517a531f2a955750f8831941891f6158498ec9b6cb1c81ce89388e63022e"
  end

  resource "unf_ext" do
    url "https://rubygems.org/gems/unf_ext-0.0.7.6.gem"
    sha256 "ae5bf2c42c6ed31942972faaf39c7bfdd97aa44530852e37c701c11589e186d2"
  end

  resource "rspec" do
    url "https://rubygems.org/gems/rspec-3.8.0.gem"
    sha256 "83f519611bb674d456e87397fea7c5b15b1af8bdc77ce929673ae3b4b656f796"
  end

  resource "rspec-core" do
    url "https://rubygems.org/gems/rspec-core-3.8.0.gem"
    sha256 "97d0b30c5687075417ac6f837c44a95e4a825007d0017fccec7a5cbcec2a3adc"
  end

  resource "rspec-support" do
    url "https://rubygems.org/gems/rspec-support-3.8.0.gem"
    sha256 "0918cc4165bb7626e518cef41046ddab90d0435868b0fb85dc90e61e733b755c"
  end

  resource "rspec-expectations" do
    url "https://rubygems.org/gems/rspec-expectations-3.8.3.gem"
    sha256 "de192f5c3f9f2916857eaee42964b062bcfdd1b822d5063506751eb77cd18fb0"
  end

  resource "diff-lcs" do
    url "https://rubygems.org/gems/diff-lcs-1.3.gem"
    sha256 "ea7bf591567e391ef262a7c29edaf87c6205204afb5bb39dfa8f08f2e51282a3"
  end

  resource "rspec-mocks" do
    url "https://rubygems.org/gems/rspec-mocks-3.8.0.gem"
    sha256 "d73b926d641676025ba086b4854f70b8a70d6cb763d50e9d278b792c1902c51b"
  end

  resource "rspec-its" do
    url "https://rubygems.org/gems/rspec-its-1.3.0.gem"
    sha256 "4da51040e7820daafd40f2f6216d13c90aa949f0d302a0412c9ef6074e73ea97"
  end

  resource "addressable" do
    url "https://rubygems.org/gems/addressable-2.6.0.gem"
    sha256 "d490ad06dfc421503e659a12597d6bb0273b5cd7ff2789a1ec27210b1914952d"
  end

  resource "tins" do
    url "https://rubygems.org/gems/tins-1.20.2.gem"
    sha256 "b2f6e9247e590228bc39d7a1fe713c284058a99d6db5c9fcf9f99b206c2112df"
  end

  resource "pry" do
    url "https://rubygems.org/gems/pry-0.12.2.gem"
    sha256 "c9bc4f2dffe767043bde6b2aad52aa24916b68727420bd38f34d860c7a383503"
  end

  resource "coderay" do
    url "https://rubygems.org/gems/coderay-1.1.2.gem"
    sha256 "9efc1b3663fa561ccffada890bd1eec3a5466808ebc711ab1c5d300617d96a97"
  end

  resource "sslshake" do
    url "https://rubygems.org/gems/sslshake-1.3.0.gem"
    sha256 "7a280238c5df4791f72283532ea298b0c3c071777a3ea8dcc2637d60b7bdc7b7"
  end

  resource "semverse" do
    url "https://rubygems.org/gems/semverse-3.0.0.gem"
    sha256 "28dc827d3376097b478c0a06111bb1259eb8341f0f2498dd23feae39c59449e3"
  end

  resource "term-ansicolor" do
    url "https://rubygems.org/gems/term-ansicolor-1.7.1.gem"
    sha256 "92339ffec77c4bddc786a29385c91601dd52fc68feda23609bba0491229b05f7"
  end

  resource "kitchen-vagrant" do
    url "https://rubygems.org/gems/kitchen-vagrant-1.5.2.gem"
    sha256 "641110d492b9c6cb962e273ed9e33f731e3b7f2f3abe9f44453d091cb4948c7f"
  end

  def install
    ENV["GEM_HOME"] = libexec
    system "gem", "build", "test-kitchen.gemspec"
    resources.each do |r|
      r.verify_download_integrity(r.fetch)
      system "gem", "install", r.cached_download, "--ignore-dependencies",
             "--no-document", "--norc", "--install-dir", libexec
    end
    system "gem", "install", "--ignore-dependencies", "--norc",
           "--no-document", "test-kitchen-#{version}.gem"
    bin.env_script_all_files(libexec/"bin", :GEM_HOME => ENV["GEM_HOME"])
    (bin/"kitchen").write_env_script(libexec/"bin/kitchen", :GEM_PATH => libexec)
  end

  test do
    system "#{bin}/kitchen", "init"
    assert_predicate testpath/"kitchen.yml", :exist?
    assert_predicate testpath/"chefignore", :exist?
    assert_predicate testpath/"test/integration/default", :exist?
  end
end
