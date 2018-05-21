public interface ITimeEntries extends fflib_ISObjectDomain {

  void startTimer(fflib_ISObjectUnitOfWork uow);
  void pauseTimer(fflib_ISObjectUnitOfWork uow);
  void resumeTimer(fflib_ISObjectUnitOfWork uow);



}
