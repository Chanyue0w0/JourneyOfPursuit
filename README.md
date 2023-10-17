# JourneyOfPursuit Git使用教學
在gitBash中使用指令按tab可提示(類似自動選字)

cd 到目標位置(例如:cd Desktop)(cd ..回到上一頁)

git clone 網址 將雲端上(github)之檔案複製下來(到目前位置)(從code中的網址)

git status 顯示目前該位置之狀態

git add . 將該目標之所有物加入git中,使其可track (.代表所有)'

git commit -m "" 在檔案中增加message(類似註解)

git push 將git內所有檔案放到雲端上(github) (要先有commit -m ""增加過,才會判定為有修改過)

ls -a 顯示目前位置所有檔案 .表示到當前位置(cd .回目前位置)..表示上一頁(cd ..回到上一頁) .檔案名稱 (隱藏檔案)

拉下檔案
git status (確認檔案是否有變更)-> git pull  (要有綠色+才行)


丟上檔案
git status(確認檔案狀態) ->"git add ."-> git commit -m "" (加入註解) ->git push

錯誤處理
"git restore 

專案合併
"git merge ."(合併專案) -> "git add ."-> git commit -m "" (加入註解) ->git push

若進入vim畫面則
按esc(退出編輯模式)(或按i回到編輯模式)，並輸入":q"以退出。(或者":wq"儲存然後退出，":q!"強制退出不儲存，)

Git commit message format
- feat: 新增/修改功能 (feature)。
- fix: 修補 bug (bug fix)。
- docs: 文件 (documentation)。
- style: 格式 (不影響程式碼運行的變動 white-space, formatting, missing semi colons, etc)。
- refactor: 重構 (既不是新增功能，也不是修補 bug 的程式碼變動)。
- perf: 改善效能 (A code change that improves performance)。
- test: 增加測試 (when adding missing tests)。
- chore: 建構程序或輔助工具的變動 (maintain)。
- revert: 撤銷回覆先前的 commit 例如：revert: type(scope): subject (回覆版本：xxxx)。
