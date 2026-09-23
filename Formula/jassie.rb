class Jassie < Formula
  include Language::Python::Virtualenv

  desc "AI-powered CLI for building, debugging, and shipping code"
  homepage "https://jassie.ai"
  license "MIT"

  url "https://github.com/Jassie-AI/homebrew-jassie/releases/download/v1.0.0/jassie-1.0.0.tar.gz"
  # Computed at release time by .github/workflows/release.yml
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  depends_on "python@3.12"
  depends_on "python-tk@3.12" => :recommended if OS.linux?

  # System libraries required by Pillow (PyAutoGUI dependency)
  depends_on "jpeg-turbo"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "webp"

  # lxml build dependency
  depends_on "libxml2"
  depends_on "libxslt"

  # tiktoken build dependency (Rust extension)
  depends_on "rust" => :build

  # ── Core dependencies ────────────────────────────────────────────────

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/a9/d2/f4d173e22df740bc37b1db102b386ba719b66e95b0f0d751f556b387e6d2/anyio-4.15.1.tar.gz"
    sha256 "9f28306018cbd6d329e64a36d58256edff76dd996fe423bc957326e578b82a94"
  end

  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/43/65/318323f98dbee45d42dff61d8f047181bc6f2268a9068cfad035a46be5af/beautifulsoup4-4.15.0.tar.gz"
    sha256 "288e3ca7d54b06f2ac191970bc275c1939cb46d450b255bf6718b04aa37ab4f7"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/a3/c2/24167ea9858356b47a87a50d39908bfdb72ceeefe0041586e704e5376b3a/certifi-2026.7.22.tar.gz"
    sha256 "741e2c3b351ddf169a738da9f2c048608ff7f2c5cc02f1ebc6b118bb090d5d55"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/e5/3f/143b048436775b0f76ac3eec145c019e8173ccc2885c8f20319b996d5e83/charset_normalizer-3.5.1.tar.gz"
    sha256 "6117b84ea48435e5356dc737f5121485c30920ba43375fa7b434fd753df0eac3"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/c7/0e/7fa0ef50764b67090eca4114772a2abf8b6148198475e54c660b97caeee6/click-8.5.0.tar.gz"
    sha256 "ba0d2089de75ea0310e2dde03160e6ca10009947fb95a182f9b54021bb272e34"
  end

  resource "defusedxml" do
    url "https://files.pythonhosted.org/packages/0f/d5/c66da9b79e5bdb124974bfe172b4daf3c984ebd9c2a06e2b8a4dc7331c72/defusedxml-0.7.1.tar.gz"
    sha256 "1bb3032db185915b62d7c6209c5a8792be6a32ab2fedacc84e01b52c51aa3e69"
  end

  resource "et_xmlfile" do
    url "https://files.pythonhosted.org/packages/d3/38/af70d7ab1ae9d4da450eeec1fa3918940a5fafb9055e934af8d6eb0c2313/et_xmlfile-2.0.0.tar.gz"
    sha256 "dab3f4764309081ce75662649be815c4c9081e88f0837825f90fd28317d4da54"
  end

  resource "fonttools" do
    url "https://files.pythonhosted.org/packages/77/51/d63c7e52163ac14393a35bd14bd7c0da95f8f74be5d7cc988092f9965129/fonttools-4.65.0.tar.gz"
    sha256 "762ba5431358d0dbd4a01982484a1d494fb267e91f974cdcf20b80eab8560f6f"
  end

  resource "fpdf2" do
    url "https://files.pythonhosted.org/packages/1e/bc/8fd4321aed40cadadddc8f311c65b6082346b252bca048f7b476d8f35d72/fpdf2-2.8.8.tar.gz"
    sha256 "9e94e155e85e8053329a9a1fce8b566fd7a7c5bb79e98a1a3952d379b947c5b9"
  end

  resource "greenlet" do
    url "https://files.pythonhosted.org/packages/3e/6e/0091f175ccd02b02bc8811bbcbcc6ac2e980be116e3b2f7a736ca322bf84/greenlet-3.5.6.tar.gz"
    sha256 "8e67c43bdfc88d5fee6db0d3e40175b362fc95fb85f0412d233b9b203c53a575"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "h2" do
    url "https://files.pythonhosted.org/packages/e7/85/7c366e69d84c17bb778fe41419e1fbcce3033d5b7ce29bbffff0a98b859f/h2-4.4.1.tar.gz"
    sha256 "4e866ffb1a869ae14dd9b5e6beb5c24a13da0495ad72b65925ded182521c1516"
  end

  resource "hpack" do
    url "https://files.pythonhosted.org/packages/26/5b/fcabf6028144a8723726318b07a32c2f3314acdff6265743cf08a344b18e/hpack-4.2.0.tar.gz"
    sha256 "0895cfa3b5531fc65fe439c05eb65144f123bf7a394fcaa56aa423548d8e45c0"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "hyperframe" do
    url "https://files.pythonhosted.org/packages/02/e7/94f8232d4a74cc99514c13a9f995811485a6903d48e5d952771ef6322e30/hyperframe-6.1.0.tar.gz"
    sha256 "f630908a00854a7adeabd6382b43923a4c4cd4b821fcb527e6ab9e15382a3b08"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f5/08/8eea9d4b8302028f3abb2c0813953f7aec26d33b7a8960ed760e65ff29fa/idna-3.20.tar.gz"
    sha256 "a7db850025b95ded1eae8a46181a1a6c56c92c96f0e2b005d9ff8dc0210cab44"
  end

  resource "lxml" do
    url "https://files.pythonhosted.org/packages/23/ad/28ecd7cb894d172f3c9c80a075eeeb2017ac62e3632cee05a5f9493547eb/lxml-6.1.3.tar.gz"
    sha256 "45222d94ddd511536f3b2f7d9deae3b2339b4ce0f075f1ca25703b07cad9dd21"
  end

  resource "markdown-it-py" do
    url "https://files.pythonhosted.org/packages/06/ff/7841249c247aa650a76b9ee4bbaeae59370dc8bfd2f6c01f3630c35eb134/markdown_it_py-4.2.0.tar.gz"
    sha256 "04a21681d6fbb623de53f6f364d352309d4094dd4194040a10fd51833e418d49"
  end

  resource "mdurl" do
    url "https://files.pythonhosted.org/packages/d6/54/cfe61301667036ec958cb99bd3efefba235e65cdeb9c84d24a8293ba1d90/mdurl-0.1.2.tar.gz"
    sha256 "bb413d29f5eea38f31dd4754dd7377d4465116fb207585f97bf925588687c1ba"
  end

  resource "MouseInfo" do
    url "https://files.pythonhosted.org/packages/28/fa/b2ba8229b9381e8f6381c1dcae6f4159a7f72349e414ed19cfbbd1817173/MouseInfo-0.1.3.tar.gz"
    sha256 "2c62fb8885062b8e520a3cce0a297c657adcc08c60952eb05bc8256ef6f7f6e7"
  end

  resource "openpyxl" do
    url "https://files.pythonhosted.org/packages/3d/f9/88d94a75de065ea32619465d2f77b29a0469500e99012523b91cc4141cd1/openpyxl-3.1.5.tar.gz"
    sha256 "cf0e3cf56142039133628b5acffe8ef0c12bc902d2aadd3e0fe5878dc08d1050"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/1c/3d/bb7fca845737cf9d7dbde16ed1843984665ff2e0a518f5db43e77ec540b9/pillow-12.3.0.tar.gz"
    sha256 "3b8182a766685eaa002637e28b4ec8d6b18819a0c71f579bf0dbaa5830297cce"
  end

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/7d/ea/39b988c938f75cb75d7045b5c69f8bfed47ee2152c8837fb403de29d6fb8/prompt_toolkit-3.0.53.tar.gz"
    sha256 "9ec8a0ad96d5c56148b3f914aa79c1564c3fde5d2e6b876e7bc327e353cf8fa6"
  end

  resource "PyAutoGUI" do
    url "https://files.pythonhosted.org/packages/65/ff/cdae0a8c2118a0de74b6cf4cbcdcaf8fd25857e6c3f205ce4b1794b27814/PyAutoGUI-0.9.54.tar.gz"
    sha256 "dd1d29e8fd118941cb193f74df57e5c6ff8e9253b99c7b04f39cfc69f3ae04b2"
  end

  resource "pyee" do
    url "https://files.pythonhosted.org/packages/8b/04/e7c1fe4dc78a6fdbfd6c337b1c3732ff543b8a397683ab38378447baa331/pyee-13.0.1.tar.gz"
    sha256 "0b931f7c14535667ed4c7e0d531716368715e860b988770fc7eb8578d1f67fc8"
  end

  resource "PyGetWindow" do
    url "https://files.pythonhosted.org/packages/e1/70/c7a4f46dbf06048c6d57d9489b8e0f9c4c3d36b7479f03c5ca97eaa2541d/PyGetWindow-0.0.9.tar.gz"
    sha256 "17894355e7d2b305cd832d717708384017c1698a90ce24f6f7fbf0242dd0a688"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/49/2e/ced460408999b33da6b31b0021b0f37d329e202d4169aeb164493778f25b/pygments-2.21.0.tar.gz"
    sha256 "610ca751c9bc2492b38eb9a38a7fbc93edbbb2d7182edaf34e66ae493dee5c8c"
  end

  resource "PyMsgBox" do
    url "https://files.pythonhosted.org/packages/ae/6a/e80da7594ee598a776972d09e2813df2b06b3bc29218f440631dfa7c78a8/pymsgbox-2.0.1.tar.gz"
    sha256 "98d055c49a511dcc10fa08c3043e7102d468f5e4b3a83c6d3c61df722c7d798d"
  end

  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/1f/ac/63d71aaedb59acbcdef491e6ca6469165e3771c9c74358204818fd9bc5a6/pypdf-6.19.0.tar.gz"
    sha256 "bbc43aca292369ccc6cbc8a921991ecf2538a3587ab5a116eff06c321d647155"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/e8/52/d87eba7cb129b81563019d1679026e7a112ef76855d6159d24754dbd2a51/pyperclip-1.11.0.tar.gz"
    sha256 "244035963e4428530d9e3a6101a1ef97209c6825edab1567beac148ccc1db1b6"
  end

  resource "PyRect" do
    url "https://files.pythonhosted.org/packages/cb/04/2ba023d5f771b645f7be0c281cdacdcd939fe13d1deb331fc5ed1a6b3a98/PyRect-0.2.0.tar.gz"
    sha256 "f65155f6df9b929b67caffbd57c0947c5ae5449d3b580d178074bffb47a09b78"
  end

  resource "PyScreeze" do
    url "https://files.pythonhosted.org/packages/ee/f0/cb456ac4f1a73723d5b866933b7986f02bacea27516629c00f8e7da94c2d/pyscreeze-1.0.1.tar.gz"
    sha256 "cf1662710f1b46aa5ff229ee23f367da9e20af4a78e6e365bee973cad0ead4be"
  end

  resource "python-docx" do
    url "https://files.pythonhosted.org/packages/a9/f7/eddfe33871520adab45aaa1a71f0402a2252050c14c7e3009446c8f4701c/python_docx-1.2.0.tar.gz"
    sha256 "7bc9d7b7d8a69c9c02ca09216118c86552704edc23bac179283f2e38f86220ce"
  end

  resource "python-pptx" do
    url "https://files.pythonhosted.org/packages/52/a9/0c0db8d37b2b8a645666f7fd8accea4c6224e013c42b1d5c17c93590cd06/python_pptx-1.0.2.tar.gz"
    sha256 "479a8af0eaf0f0d76b6f00b0887732874ad2e3188230315290cd1f9dd9cc7095"
  end

  resource "pytweening" do
    url "https://files.pythonhosted.org/packages/79/0c/c16bc93ac2755bac0066a8ecbd2a2931a1735a6fffd99a2b9681c7e83e90/pytweening-1.2.0.tar.gz"
    sha256 "243318b7736698066c5f362ec5c2b6434ecf4297c3c8e7caa8abfe6af4cac71b"
  end

  resource "regex" do
    url "https://files.pythonhosted.org/packages/b9/5c/f403115361de25809e8f785686ec7096e30fef73be9ae35aa51da4e80abb/regex-2026.9.10.tar.gz"
    sha256 "1e321e2c84f0e52c457f5ea5944f796d6e8e09cb99738ea98dcc1bfe402a128d"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/ac/c3/e2a2b89f2d3e2179abd6d00ebd70bff6273f37fb3e0cc209f48b39d00cbf/requests-2.34.2.tar.gz"
    sha256 "f288924cae4e29463698d6d60bc6a4da69c89185ad1e0bcc4104f584e960b9ed"
  end

  resource "rich" do
    url "https://files.pythonhosted.org/packages/c0/8f/0722ca900cc807c13a6a0c696dacf35430f72e0ec571c4275d2371fca3e9/rich-15.0.0.tar.gz"
    sha256 "edd07a4824c6b40189fb7ac9bc4c52536e9780fbbfbddf6f1e2502c31b068c36"
  end

  resource "setproctitle" do
    url "https://files.pythonhosted.org/packages/8d/48/49393a96a2eef1ab418b17475fb92b8fcfad83d099e678751b05472e69de/setproctitle-1.3.7.tar.gz"
    sha256 "bc2bc917691c1537d5b9bca1468437176809c7e11e5694ca79a9ca12345dcb9e"
  end

  resource "soupsieve" do
    url "https://files.pythonhosted.org/packages/69/99/a6ca3beb3ccacb41fb3321d8a60e5566f9e6467601ef8eba6a17e1b89778/soupsieve-2.9.2.tar.gz"
    sha256 "4a55d8cf158a9c2e587fa4922f1bbb91d68ac829e2d6f25403a85747c71daf74"
  end

  resource "tiktoken" do
    url "https://files.pythonhosted.org/packages/66/62/167a842aa0429d45f5e797354fd4343a96f6043d67d0513c675c7b8d36e6/tiktoken-0.14.0.tar.gz"
    sha256 "231dec90efcdccf1b565a1416107736f1e09b1a08fe736ef9d6363e626d03874"
  end

  resource "typing_extensions" do
    url "https://files.pythonhosted.org/packages/f6/cc/6253133b5bb138fc3306cebfbda2c520f545d36b5be2c7255cc528bb45d6/typing_extensions-4.16.0.tar.gz"
    sha256 "dc983d19a509c94dba722ee6abd33940f7c05a89e243c47e907eb4db6f1a43e5"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/e3/05/b17359e1cefb4f909b5e40b1b90a496d987258916dbbf88e842c729f510e/urllib3-2.8.0.tar.gz"
    sha256 "63bf2ead4c879426ebf22ef2a781eeb4aa3b4ae798a0435506f8687fd5bb9b63"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/3d/7a/f98d4ada7c499565ab0c0fcef28a4e54fafa72b8228a6309803c80493c92/wcwidth-0.8.4.tar.gz"
    sha256 "2dae09efa25253ae2874188e86d6861af3b1652aef4118cdf3f0bda288a957fb"
  end

  resource "xlsxwriter" do
    url "https://files.pythonhosted.org/packages/46/2c/c06ef49dc36e7954e55b802a8b231770d286a9758b3d936bd1e04ce5ba88/xlsxwriter-3.2.9.tar.gz"
    sha256 "254b1c37a368c444eac6e2f867405cc9e461b0ed97a3233b2ac1e574efb4140c"
  end

  # ── Playwright (no sdist — platform-specific wheels) ─────────────────

  on_macos do
    on_arm do
      resource "playwright" do
        url "https://files.pythonhosted.org/packages/f5/9a/948b930b1a8c4ee869e5a139a2b7747caa06aab56a3f09a2f0abdcbda221/playwright-1.63.0-py3-none-macosx_11_0_arm64.whl"
        sha256 "fd1aa00631d44d55e56e0975bf3f3f285fac4a9fd2813183f0c12a488f1a1b24"
      end
    end
    on_intel do
      resource "playwright" do
        url "https://files.pythonhosted.org/packages/19/dd/fbb3d34228ad753bc14464d5f2252585b73367539775a88d0a3949cf5a45/playwright-1.63.0-py3-none-macosx_10_13_x86_64.whl"
        sha256 "84c540759e8e7f01e690e197e04060f48899d37cea322299f255843273d3385d"
      end
    end
  end

  on_linux do
    on_arm do
      resource "playwright" do
        url "https://files.pythonhosted.org/packages/f3/82/3d85505284c5a210f2da6c07b8f757524e79d1fba9cfdafe1eafb766ae59/playwright-1.63.0-py3-none-manylinux_2_17_aarch64.manylinux2014_aarch64.whl"
        sha256 "354e15b29503565fc598b89f16fbe070459343bef9d7498a93e304864000c6a7"
      end
    end
    on_intel do
      resource "playwright" do
        url "https://files.pythonhosted.org/packages/27/9c/103a5037789062bdab27c7dca53f3ca6b075b572ab2cd96eec825b3aec4e/playwright-1.63.0-py3-none-manylinux1_x86_64.whl"
        sha256 "ad21bc07516b187965a7521c5cf0df0bd657b17482eaad74335272d35a2b07de"
      end
    end
  end

  # ── macOS-only dependencies (PyAutoGUI → pyobjc) ────────────────────

  on_macos do
    resource "pyobjc-core" do
      url "https://files.pythonhosted.org/packages/a5/78/abc4ce5920305780aeb36b4067a86253378b36e29ba96673a3deb02eb03a/pyobjc_core-12.2.2.tar.gz"
      sha256 "3906452339cd06a3bb07df103c2511d4cb0f7a22d8771c0b802eba15d9a642b6"
    end

    resource "pyobjc-framework-Cocoa" do
      url "https://files.pythonhosted.org/packages/75/76/49c6da2c6a831020b4854ba20079d5a1030474bffc776b7b73c2eeff8c15/pyobjc_framework_cocoa-12.2.2.tar.gz"
      sha256 "c96c0ef69a71afbbb0e6a7d594b455c5fe47d62e0db376ee7a2b4b828c16ace9"
    end

    resource "pyobjc-framework-Quartz" do
      url "https://files.pythonhosted.org/packages/35/b1/426a37c7ae37280b3ffca2571fb48f211946aee2f4ca31a603ed1943c4a7/pyobjc_framework_quartz-12.2.2.tar.gz"
      sha256 "810f97b210cfd93704d240860286dfd6df09f9f1c52525fc5c2166723aea3f9e"
    end

    resource "rubicon-objc" do
      url "https://files.pythonhosted.org/packages/0d/26/3e6bb0bfd41ff446d29931205088556055ec18c31bf099d6719c281c448c/rubicon_objc-0.5.6.tar.gz"
      sha256 "0d3b0a9889f72916c095a58e7e1c275c260cb8a86b8ef8b909e60cb002fd54d5"
    end
  end

  def install
    # Create virtualenv manually so we can handle wheel-only packages
    venv = virtualenv_create(libexec, "python3.12")

    # Install all resources EXCEPT playwright (which is wheel-only, no sdist)
    venv.pip_install resources.reject { |r| r.name == "playwright" }

    # Playwright has no sdist — only platform-specific wheels.
    # Homebrew prefixes cached downloads with a hash (e.g. "abc123--playwright-1.63.0-...whl")
    # which breaks pip's wheel filename parser.  Copy to a clean name first.
    resource("playwright").stage do
      cached = resource("playwright").cached_download
      # Strip the Homebrew hash prefix from the filename
      clean_name = File.basename(cached.to_s).sub(/\A[0-9a-f]+--/, "")
      clean_whl  = buildpath/clean_name
      cp cached, clean_whl
      system libexec/"bin/python", "-m", "pip", "install",
             "--no-deps", "--no-index", clean_whl
    end

    # Install the main package and symlink the binary
    venv.pip_install_and_link buildpath
    bin.install_symlink libexec/"bin/jassie"
  end

  def caveats
    <<~EOS
      To use browser automation features, install Playwright browsers:
        jassie playwright-install
      or:
        playwright install chromium
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/jassie --version")
  end
end
