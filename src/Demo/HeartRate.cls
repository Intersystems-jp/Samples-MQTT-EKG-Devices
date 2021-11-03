/// プロダクションで使用している応答メッセージ（レスポンス）。
/// データ変換のターゲット指定に利用しています。
/// MQTTトピックとトピックの値を永続オブジェクトに変換するときに使用しています。
Class Demo.HeartRate Extends (Ens.Response)
{

Property PatientID As %String;

Property BPM As %Integer;

// 保存時のタイムスタンプを登録します
Property TimeStamp As %DateTime [ InitialExpression = {$ZDATETIME($ZTIMESTAMP)} ];

}
