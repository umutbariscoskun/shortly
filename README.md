# shortly



# Proje Adımları

Projede Clean Architecture kurulumu yapıp domain katmanından kodlamaya başladım. İlk önce entity sonra abstract repo ve usecaseleri kodladım. Data Repoyu açıp abstract repodaki metotları override ettim. Son katman olarak View katmanında presenterdan kodlamaya başlayarak observer metotlarımı belirledim ve observerın içinde eror ve tamamlanma durumlarını ayarladım. Controller sayfasını kodlayıp ihtiyacım olan metotları yazdım. En son arayüzü kodladım. 

Projede genel olarak stringleri, renkleri, paddingleri constant olarak tanımlamaya ve düzenli tutmaya çalıştım. Arayüzde paddingleri ve fontları birebir olmasa da yakın şekilde kodlamaya çalıştım. Svg kütüphanesini indirdim ve sıkça da kullandım fakat GitHub' tan direkt indirirken sanırım formatında bozulma oluyor. Projede eksik çıkıyor görseller. Figmaya çekip oradan export etmeyi denedim yine olmadı. Ben de png olarak export edip kullandım. 

Bloc pattern de hiç kullanmadım Clean Architecture paketinde provider da geliyor. ViewState' te controller verirken aslında bu provider'a controller veriyoruz. Bu şekilde viewin state'ini yönetebiliyoruz. Ayrı bir state management paketi kurmadım. Api' yi çok beğendim ve keşke daha önce görseydim dedim. Yazarken çok eğlendim bunun için de size teşekkürlerimi iletmek isterim. 



# shortly
