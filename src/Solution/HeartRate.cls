/// プロダクションで使用している応答メッセージ（レスポンス）。
/// データ変換のターゲット指定に利用しています。
/// MQTTトピックとトピックの値を永続オブジェクトに変換するときに使用しています。
Class Solution.HeartRate Extends (Ens.Response, %Populate)
{

Property PatientID As %String;

Property BPM As %Integer;

/// 保存時のタイムスタンプを登録します
///$system.Util.UTCtoLocalWithZTIMEZONE($ZTIMESTAMP) は実行環境のローカルタイムにタイムスタンプを合わせています
Property TimeStamp As %DateTime [ InitialExpression = {$ZDATETIME($system.Util.UTCtoLocalWithZTIMEZONE($ZTIMESTAMP))} ];


}
