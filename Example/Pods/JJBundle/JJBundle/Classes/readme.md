/* 
  readme.md
  Pods

  Created by chiehchun.lee on 2021/4/21.
  
*/
##1. Create bundle and put resource into the bundle by cocoapods.
in .podspec
'''
s.resource_bundles = {
  '_bundleName' => ['[framework]/Assets/**/*','[framework]/**/*.{js}']
}
'''

##2. Create your project's Bundle DSL,
'''
public extension Bundle {
    static var myBundle : JKOBundleDSL? {
        return JKOBundleDSL(mainBundleName: "_bundleName", anyClassNameInSameBundle: "_bundleName._bundleNameViewController")
    }
}
'''

##3. Use your bundle through DSL
'''
Bundle.myBundle?.main?.fetchJSScript(with: fileName)
'''
