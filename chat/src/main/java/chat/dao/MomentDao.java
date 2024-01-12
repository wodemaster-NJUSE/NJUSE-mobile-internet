package chat.dao;

import chat.pojo.entity.MomentEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Date;

public interface MomentDao extends JpaRepository<MomentEntity,Long> {
    MomentEntity findByMomentUid(String momentUid);
    void deleteByMomentUid(String momentUid);
}
