/// ビジネスメトリッククラス
/// 詳細は、以下ドキュメントをご参照ください。
/// https://docs.intersystems.com/irisforhealthlatestj/csp/docbook/DocBook.UI.Page.cls?KEY=EGDV_bmetric
Class Solution.MetricMQTT Extends Ens.BusinessMetric
{


/// インスタンス毎（サンプルでは心電図を付けた患者毎）の現在の心拍数を格納するために用意するプロパティ
/// データタイプは専用のタイプを使用します（Ens.DataType.Metric）
Property BPM As Ens.DataType.Metric;


/// ダッシュボードのグラフ表示に使用する患者毎の心拍数を取得するため
/// データベース登録されている患者のpatientIDを取得しています。
/// 今回のサンプルでは患者が追加されることを想定しているため、
/// OnCalculateMetrics()実行時に存在する全患者のPatientIDを動的に取得できるように
/// このクエリを使用しています。（MetricInstances()の名称で作成する必要があります） 
Query MetricInstances() As %SQLQuery
{
  select distinct patientID from Solution.HeartRate
}

/// このメソッドはプロダクション定義のメトリッククラスの「呼び出し間隔」で設定した
/// 間隔で定期的に実行されます。
/// MetricInstances()で既存患者のPatientIDが取得でき、メトリッククラスの仕様として
/// %Instanceプロパティにその値が格納されるため、患者ごとの心拍数を取得する条件に指定しています。
/// (患者ごとのBPMをSELECT文で取得し、BPMプロパティにセットします)
Method OnCalculateMetrics() As %Status
{ 
    // MetricInstances()で取得できたPatientID毎にこのメソッドが呼び出されます。
    set patient = ..%Instance

   // 指定患者の直近の心拍数を取得し、ローカル変数（ホスト変数）bpmに設定
     &SQL(SELECT TOP 1 BPM INTO :bpm
              FROM Solution.HeartRate
              WHERE PatientID = :patient ORDER BY TimeStamp DESC)
    
    //インスタンス毎（＝取得できた患者ごと）にメトリッククラスのBPMプロパティの値を更新します
    set ..BPM = bpm

    return $$$OK
}


}
