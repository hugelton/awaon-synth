#!/usr/bin/env osascript

# Install Awaon Initial Preset
# このスクリプトは Init.awaon を正しいフォルダに配置します

on run
    -- ファイル選択ダイアログ
    set presetFile to choose file with prompt "Init.awaon ファイルを選択してください:" of type {"awaon", "public.data"}

    -- ターゲットフォルダ
    set targetFolder to (path to library folder from user domain) & "Audio:Presets:Hugelton:Awaon:"

    -- フォルダ作成
    try
        tell application "Finder"
            if not (exists folder targetFolder) then
                create folder targetFolder
            end if

            -- Wavetables フォルダも作成
            if not (exists folder (targetFolder & "Wavetables:")) then
                create folder (targetFolder & "Wavetables:")
            end if

            -- ファイルをコピー
            duplicate presetFile to folder targetFolder with replacing
        end tell

        display alert "成功" message "Init.awaon が正常にインストールされました。\n\n" & targetFolder buttons {"OK"} default button 1

    on error errMsg
        display alert "エラー" message "インストールに失敗しました:\n\n" & errMsg buttons {"OK"} default button 1
    end try
end run
