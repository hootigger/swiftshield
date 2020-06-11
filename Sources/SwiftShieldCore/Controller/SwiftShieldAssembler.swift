import Foundation

public enum SwiftSwiftAssembler {
    public static func generate(
        projectPath: String,
        scheme: String,
        modulesToIgnore: Set<String>,
        ignorePublic: Bool,
        dryRun: Bool,
        verbose: Bool,
        printSourceKitQueries: Bool,
        blackListFilePath: String?
    ) -> SwiftShieldController {
        let logger = Logger(
            verbose: verbose,
            printSourceKit: printSourceKitQueries
        )

        let projectFile = File(path: projectPath)
        let taskRunner = TaskRunner()
        let infoProvider = SchemeInfoProvider(
            projectFile: projectFile,
            schemeName: scheme,
            taskRunner: taskRunner,
            logger: logger,
            modulesToIgnore: modulesToIgnore
        )

        let sourceKit = SourceKit(logger: logger)
        let obfuscator = SourceKitObfuscator(
            sourceKit: sourceKit,
            logger: logger,
            dataStore: .init(),
            ignorePublic: ignorePublic
        )

        /// 读取 黑名单列表
        let file = File(path: blackListFilePath ?? "")
        if let content = try? file.read() {
            let arr = content.components(separatedBy: .newlines).filter { $0.trimmingCharacters(in: .whitespaces).isEmpty }
            obfuscator.dataStore.obfuscationBlackList = Set<String>(arr)
            obfuscator.logger.log("------------obfuscationBlackList读取完毕(\(obfuscator.dataStore.obfuscationBlackList.count))--------------")
        }
        
        let interactor = SwiftShieldInteractor(
            schemeInfoProvider: infoProvider,
            logger: logger,
            obfuscator: obfuscator
        )

        return SwiftShieldController(
            interactor: interactor,
            logger: logger,
            dryRun: dryRun
        )
    }
}
